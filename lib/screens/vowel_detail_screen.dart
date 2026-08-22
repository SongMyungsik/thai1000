import 'package:flutter/material.dart';

import '../models/vowel.dart';
import '../services/tts_service.dart';

class VowelDetailScreen extends StatelessWidget {
  const VowelDetailScreen({super.key, required this.vowel, required this.tts});

  final Vowel vowel;
  final TtsService tts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(vowel.name)),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Column(
              children: [
                Text(vowel.displayForm, style: const TextStyle(fontSize: 72.0)),
                const SizedBox(height: 8.0),
                Chip(label: Text(vowel.length.label)),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('소리', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8.0),
                  _InfoRow('로마자 표기', vowel.romanization),
                  _InfoRow('한글 근사음', vowel.koreanApprox),
                  _InfoRow('연습 음절', vowel.demoSyllable),
                  const SizedBox(height: 12.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FilledButton.icon(
                      onPressed: () => tts.speak(vowel.demoSyllable),
                      icon: const Icon(Icons.volume_up),
                      label: const Text('연습 음절 발음 듣기'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('예시 단어', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8.0),
                  _InfoRow('단어', '${vowel.exampleWord} (${vowel.exampleWordRoman})'),
                  _InfoRow('뜻', vowel.exampleMeaning),
                  const SizedBox(height: 12.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FilledButton.icon(
                      onPressed: () => tts.speak(vowel.exampleWord),
                      icon: const Icon(Icons.volume_up),
                      label: const Text('예시 단어 발음 듣기'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 88.0,
            child: Text(
              label,
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
