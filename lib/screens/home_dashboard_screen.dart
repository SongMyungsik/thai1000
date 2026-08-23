import 'package:flutter/material.dart';

import '../data/consonants_data.dart';
import '../data/conversations_data.dart';
import '../data/vowels_data.dart';
import '../data/words_data.dart';
import '../services/tts_service.dart';
import 'guide_screen.dart';
import 'tts_diagnostics_screen.dart';

/// "홈" 탭: 환영 문구와 학습 콘텐츠 요약만 보여주는 대시보드.
class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key, required this.tts});

  final TtsService tts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('태국어 배우기'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: '학습 가이드',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const GuideScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            '안녕하세요! 👋',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            '아래 하단 탭에서 자음모음 → 단어 → 성조 → 회화 순으로 배우고, '
            '퀴즈로 복습해보세요.',
          ),
          const SizedBox(height: 24.0),
          Text('학습 콘텐츠 현황', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8.0),
          Row(
            children: [
              _StatTile(label: '자음', count: consonants.length),
              const SizedBox(width: 8.0),
              _StatTile(label: '모음', count: vowels.length),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              _StatTile(label: '단어', count: words.length),
              const SizedBox(width: 8.0),
              _StatTile(label: '대화', count: dialogues.length),
            ],
          ),
          const SizedBox(height: 24.0),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TtsDiagnosticsScreen(tts: tts),
                ),
              );
            },
            icon: const Icon(Icons.volume_up_outlined),
            label: const Text('발음이 안 나오나요? TTS 문제 진단'),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.count});

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              Text(
                '$count',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
