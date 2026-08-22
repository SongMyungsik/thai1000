import 'package:flutter/material.dart';

import '../models/quiz.dart';
import '../services/quiz_generator.dart';
import '../services/tts_service.dart';
import 'quiz_play_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key, required this.tts});

  final TtsService tts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('퀴즈')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('지금까지 배운 내용을 4지선다 퀴즈로 점검해보세요.'),
          const SizedBox(height: 16.0),
          _QuizCard(
            icon: Icons.abc,
            title: '자음 퀴즈',
            subtitle: '글자 → 이름/클래스 맞추기',
            onTap: () => _open(context, '자음 퀴즈', generateConsonantQuiz, withTts: true),
          ),
          _QuizCard(
            icon: Icons.record_voice_over,
            title: '모음 퀴즈',
            subtitle: '형태 → 발음/종류 맞추기',
            onTap: () => _open(context, '모음 퀴즈', generateVowelQuiz, withTts: true),
          ),
          _QuizCard(
            icon: Icons.menu_book,
            title: '단어 퀴즈',
            subtitle: '태국어 ↔ 뜻 맞추기',
            onTap: () => _open(context, '단어 퀴즈', generateWordQuiz, withTts: true),
          ),
          _QuizCard(
            icon: Icons.music_note,
            title: '성조 퀴즈',
            subtitle: '조건 → 성조 계산 맞추기',
            onTap: () => _open(context, '성조 퀴즈', generateToneQuiz, withTts: false),
          ),
        ],
      ),
    );
  }

  void _open(
    BuildContext context,
    String title,
    List<QuizQuestion> Function({int count}) generator, {
    required bool withTts,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => QuizPlayScreen(
          title: title,
          questionsBuilder: () => generator(count: 10),
          tts: withTts ? tts : null,
        ),
      ),
    );
  }
}

class _QuizCard extends StatelessWidget {
  const _QuizCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, size: 32.0),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
