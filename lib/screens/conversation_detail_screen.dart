import 'package:flutter/material.dart';

import '../data/words_data.dart';
import '../models/conversation.dart';
import '../services/tts_service.dart';
import 'word_detail_screen.dart';

class ConversationDetailScreen extends StatelessWidget {
  const ConversationDetailScreen({
    super.key,
    required this.dialogue,
    required this.tts,
  });

  final Dialogue dialogue;
  final TtsService tts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(dialogue.title)),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          for (final line in dialogue.lines) ...[
            _DialogueBubble(line: line, tts: tts),
            const SizedBox(height: 12.0),
          ],
        ],
      ),
    );
  }
}

class _DialogueBubble extends StatelessWidget {
  const _DialogueBubble({required this.line, required this.tts});

  final DialogueLine line;
  final TtsService tts;

  @override
  Widget build(BuildContext context) {
    final isA = line.speaker == Speaker.a;
    final colorScheme = Theme.of(context).colorScheme;
    final bubbleColor = isA
        ? colorScheme.surfaceContainerHighest
        : colorScheme.primaryContainer;
    final onBubbleColor = isA
        ? colorScheme.onSurfaceVariant
        : colorScheme.onPrimaryContainer;

    final bubble = Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  line.thai,
                  style: TextStyle(fontSize: 20.0, color: onBubbleColor),
                ),
              ),
              IconButton(
                icon: Icon(Icons.volume_up, color: onBubbleColor),
                onPressed: () => tts.speak(line.thai),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          Text(line.romanization, style: TextStyle(color: onBubbleColor)),
          const SizedBox(height: 4.0),
          Text(line.meaningKorean, style: TextStyle(color: onBubbleColor)),
          if (line.relatedWords.isNotEmpty) ...[
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: [
                for (final wordThai in line.relatedWords)
                  ActionChip(
                    label: Text(wordThai),
                    onPressed: () => _openWord(context, wordThai),
                  ),
              ],
            ),
          ],
        ],
      ),
    );

    return Row(
      mainAxisAlignment:
          isA ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment:
                isA ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Text(isA ? 'A' : 'B', style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 2.0),
              bubble,
            ],
          ),
        ),
      ],
    );
  }

  void _openWord(BuildContext context, String wordThai) {
    final word = words.firstWhere((w) => w.thai == wordThai);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WordDetailScreen(word: word, tts: tts),
      ),
    );
  }
}
