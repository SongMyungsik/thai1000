import 'package:flutter/material.dart';

import '../models/quiz.dart';
import '../services/tts_service.dart';

class QuizPlayScreen extends StatefulWidget {
  const QuizPlayScreen({
    super.key,
    required this.title,
    required this.questionsBuilder,
    this.tts,
  });

  final String title;

  /// 새 문제 세트를 만드는 함수. "다시 풀기"에서 다시 호출해 매번 새로 섞는다.
  final List<QuizQuestion> Function() questionsBuilder;
  final TtsService? tts;

  @override
  State<QuizPlayScreen> createState() => _QuizPlayScreenState();
}

class _QuizPlayScreenState extends State<QuizPlayScreen> {
  late List<QuizQuestion> _questions;
  int _index = 0;
  int _score = 0;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _questions = widget.questionsBuilder();
  }

  void _restart() {
    setState(() {
      _questions = widget.questionsBuilder();
      _index = 0;
      _score = 0;
      _selectedIndex = null;
    });
  }

  void _selectOption(int optionIndex) {
    if (_selectedIndex != null) return;
    setState(() {
      _selectedIndex = optionIndex;
      if (optionIndex == _questions[_index].correctIndex) {
        _score++;
      }
    });
  }

  void _next() {
    setState(() {
      _index++;
      _selectedIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isFinished = _index >= _questions.length;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isFinished ? widget.title : '${widget.title} (${_index + 1}/${_questions.length})',
        ),
      ),
      body: isFinished ? _buildResult(context) : _buildQuestion(context),
    );
  }

  Widget _buildQuestion(BuildContext context) {
    final question = _questions[_index];
    final answered = _selectedIndex != null;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(question.hint, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 16.0),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  question.prompt,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 32.0),
                ),
              ),
              if (widget.tts != null) ...[
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.volume_up),
                  onPressed: () => widget.tts!.speak(question.prompt),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 24.0),
        for (var i = 0; i < question.options.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: _OptionButton(
              text: question.options[i],
              state: !answered
                  ? _OptionState.neutral
                  : i == question.correctIndex
                      ? _OptionState.correct
                      : i == _selectedIndex
                          ? _OptionState.wrong
                          : _OptionState.neutral,
              onTap: () => _selectOption(i),
            ),
          ),
        if (answered) ...[
          const SizedBox(height: 8.0),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(question.explanation),
            ),
          ),
          const SizedBox(height: 16.0),
          FilledButton(
            onPressed: _next,
            child: Text(
              _index + 1 < _questions.length ? '다음 문제' : '결과 보기',
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildResult(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('결과', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12.0),
          Text(
            '$_score / ${_questions.length} 문제 정답',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 24.0),
          FilledButton.icon(
            onPressed: _restart,
            icon: const Icon(Icons.refresh),
            label: const Text('다시 풀기'),
          ),
          const SizedBox(height: 8.0),
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('메뉴로'),
          ),
        ],
      ),
    );
  }
}

enum _OptionState { neutral, correct, wrong }

class _OptionButton extends StatelessWidget {
  const _OptionButton({
    required this.text,
    required this.state,
    required this.onTap,
  });

  final String text;
  final _OptionState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color? background = switch (state) {
      _OptionState.correct => Colors.green.shade100,
      _OptionState.wrong => Colors.red.shade100,
      _OptionState.neutral => null,
    };
    final Color? foreground = switch (state) {
      _OptionState.correct => Colors.green.shade900,
      _OptionState.wrong => Colors.red.shade900,
      _OptionState.neutral => null,
    };

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          padding: const EdgeInsets.symmetric(vertical: 14.0),
        ),
        child: Text(text, style: const TextStyle(fontSize: 16.0)),
      ),
    );
  }
}
