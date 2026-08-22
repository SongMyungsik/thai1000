import 'package:flutter/material.dart';

import '../models/tone.dart';
import '../services/tts_service.dart';
import '../widgets/tone_contour_chart.dart';
import 'tone_calculator_screen.dart';
import 'tone_rules_screen.dart';
import 'words_screen.dart';

class ToneScreen extends StatelessWidget {
  const ToneScreen({super.key, required this.tts});

  final TtsService tts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('성조')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            '태국어는 같은 글자라도 음의 높낮이(성조)가 다르면 뜻이 달라집니다. '
            '성조는 ①자음 클래스 ②생음절/사음절 ③성조 부호, 이 세 가지로 규칙적으로 정해집니다.',
          ),
          const SizedBox(height: 16.0),
          for (final tone in Tone.values)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ToneContourChart(tone: tone),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text('${tone.arrow} ${tone.label} — ${tone.description}'),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8.0),
          Text(
            '(위 예시는 실제 단어가 아니라 발음 연습용 음절입니다: ก(까) → ก่(까↓) → ก้(까↘) → ก๊(까↑) → ก๋(까↗))',
            style: TextStyle(fontSize: 12.0, color: Theme.of(context).colorScheme.outline),
          ),
          const SizedBox(height: 24.0),
          _NavCard(
            icon: Icons.table_chart_outlined,
            title: '성조 규칙표',
            subtitle: '자음 클래스 × 음절 유형/성조 부호 → 성조 표',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ToneRulesScreen()),
            ),
          ),
          _NavCard(
            icon: Icons.calculate_outlined,
            title: '성조 계산기',
            subtitle: '조건을 직접 선택해서 성조를 계산해보기',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ToneCalculatorScreen()),
            ),
          ),
          _NavCard(
            icon: Icons.menu_book_outlined,
            title: '단어로 확인하기',
            subtitle: '단어 학습에서 배운 단어의 성조를 단어 상세 화면에서 확인',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => WordsScreen(tts: tts)),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavCard extends StatelessWidget {
  const _NavCard({
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
