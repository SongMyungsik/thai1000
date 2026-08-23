import 'package:flutter/material.dart';

import '../models/consonant.dart';
import '../services/tts_service.dart';

class ConsonantDetailScreen extends StatelessWidget {
  const ConsonantDetailScreen({
    super.key,
    required this.consonant,
    required this.tts,
  });

  final Consonant consonant;
  final TtsService tts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${consonant.romanName} · ${consonant.koreanName}')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Column(
              children: [
                Text(consonant.char, style: const TextStyle(fontSize: 96.0)),
                const SizedBox(height: 8.0),
                Chip(
                  label: Text(consonant.consonantClass.label),
                  backgroundColor: consonant.consonantClass.backgroundColor,
                  labelStyle: TextStyle(
                    color: consonant.consonantClass.foregroundColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
          _InfoCard(
            title: '초성일 때 소리',
            trailing: FilledButton.icon(
              onPressed: () => tts.speak(consonant.char),
              icon: const Icon(Icons.volume_up),
              label: const Text('글자 발음 듣기'),
            ),
            children: [
              _InfoRow('로마자 표기', consonant.initialSoundRoman),
              _InfoRow('설명', consonant.initialSoundKorean),
            ],
          ),
          const SizedBox(height: 12.0),
          _InfoCard(
            title: '종성(받침)일 때 소리',
            children: [
              if (consonant.finalGroup.romanSuffix != null)
                _InfoRow('로마자 표기', consonant.finalGroup.romanSuffix!),
              _InfoRow('설명', consonant.finalGroup.koreanDescription),
            ],
          ),
          const SizedBox(height: 12.0),
          _InfoCard(
            title: '✍️ 쓰는 법 힌트',
            children: [
              Text(
                '${consonant.char}에 동그란 부분(머리)이 있다면, 그 부분을 가장 먼저 '
                '시계 반대 방향으로 그려보세요. 태국어 글자 대부분에 적용되는 원칙입니다.',
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          _InfoCard(
            title: '예시 단어',
            trailing: FilledButton.icon(
              onPressed: () => tts.speak(consonant.exampleWord),
              icon: const Icon(Icons.volume_up),
              label: const Text('예시 단어 발음 듣기'),
            ),
            children: [
              _InfoRow('단어', '${consonant.exampleWord} (${consonant.exampleWordRoman})'),
              _InfoRow('뜻', consonant.exampleMeaning),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.children, this.trailing});

  final String title;
  final List<Widget> children;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8.0),
            ...children,
            if (trailing != null) ...[
              const SizedBox(height: 12.0),
              Align(alignment: Alignment.centerLeft, child: trailing),
            ],
          ],
        ),
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
            width: 72.0,
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
