import 'package:flutter/material.dart';

import '../data/consonants_data.dart';
import '../data/vowels_data.dart';
import '../models/tone.dart';
import '../models/word.dart';
import '../services/tts_service.dart';
import 'consonant_detail_screen.dart';
import 'vowel_detail_screen.dart';

class WordDetailScreen extends StatelessWidget {
  const WordDetailScreen({super.key, required this.word, required this.tts});

  final Word word;
  final TtsService tts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(word.romanization)),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Column(
              children: [
                Text(word.thai, style: const TextStyle(fontSize: 56.0)),
                const SizedBox(height: 8.0),
                Chip(label: Text(word.category.label)),
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
                  Text('뜻', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8.0),
                  Text('로마자: ${word.romanization}'),
                  const SizedBox(height: 4.0),
                  Text('뜻: ${word.meaningKorean}'),
                  const SizedBox(height: 12.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FilledButton.icon(
                      onPressed: () => tts.speak(word.thai),
                      icon: const Icon(Icons.volume_up),
                      label: const Text('단어 발음 듣기'),
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
                  Text('음절 분해', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4.0),
                  Text(
                    '음절을 이루는 자음·모음을 눌러서 자세히 복습해보세요.',
                    style: TextStyle(color: Theme.of(context).colorScheme.outline),
                  ),
                  const SizedBox(height: 12.0),
                  for (final syllable in word.syllables) ...[
                    _SyllableCard(syllable: syllable, tts: tts),
                    const SizedBox(height: 8.0),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SyllableCard extends StatelessWidget {
  const _SyllableCard({required this.syllable, required this.tts});

  final WordSyllablePart syllable;
  final TtsService tts;

  @override
  Widget build(BuildContext context) {
    final tone = toneOfSyllable(syllable);
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                syllable.syllableText,
                style: const TextStyle(fontSize: 28.0),
              ),
              const SizedBox(width: 8.0),
              Text('(${syllable.syllableRoman})'),
              const Spacer(),
              Chip(
                label: Text('${tone.arrow} ${tone.label}'),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              if (syllable.initialConsonantChar != null)
                _PartChip(
                  label: '초성 ${syllable.initialConsonantChar}',
                  onTap: () => _openConsonant(context, syllable.initialConsonantChar!),
                ),
              if (syllable.vowelDisplayForm != null)
                _PartChip(
                  label: '모음 ${syllable.vowelDisplayForm}',
                  onTap: () => _openVowel(context, syllable.vowelDisplayForm!),
                ),
              if (syllable.finalConsonantChar != null)
                _PartChip(
                  label: '받침 ${syllable.finalConsonantChar}',
                  onTap: () => _openConsonant(context, syllable.finalConsonantChar!),
                )
              else
                const Chip(label: Text('받침 없음')),
            ],
          ),
          if (syllable.note != null) ...[
            const SizedBox(height: 8.0),
            Text(
              syllable.note!,
              style: TextStyle(
                fontSize: 12.0,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _openConsonant(BuildContext context, String char) {
    final consonant = consonants.firstWhere((c) => c.char == char);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ConsonantDetailScreen(consonant: consonant, tts: tts),
      ),
    );
  }

  void _openVowel(BuildContext context, String displayForm) {
    final vowel = vowels.firstWhere((v) => v.displayForm == displayForm);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => VowelDetailScreen(vowel: vowel, tts: tts),
      ),
    );
  }
}

class _PartChip extends StatelessWidget {
  const _PartChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(label: Text(label), onPressed: onTap);
  }
}
