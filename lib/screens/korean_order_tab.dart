import 'package:flutter/material.dart';

import '../data/consonants_data.dart';
import '../models/consonant.dart';
import '../services/tts_service.dart';
import 'consonant_detail_screen.dart';

/// 태국어 자음을 발음이 가장 가까운 한글 자음 순서로 묶어서 보여주는 탭.
class KoreanOrderTab extends StatelessWidget {
  const KoreanOrderTab({super.key, required this.tts});

  final TtsService tts;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Wrap(
          spacing: 16.0,
          runSpacing: 8.0,
          children: [
            _LegendItem(color: ConsonantClass.mid.backgroundColor, label: '중자음'),
            _LegendItem(color: ConsonantClass.high.backgroundColor, label: '고자음'),
            _LegendItem(color: ConsonantClass.low.backgroundColor, label: '저자음'),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          '태국어에는 한글에 없는 무기음·유기음 구분이 있어서 완전히 같지는 않지만, '
          '발음이 가장 비슷한 한글 자음끼리 묶었습니다.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey),
        ),
        const SizedBox(height: 16.0),
        for (final group in koreanGroupOrder) _buildGroupRow(context, group),
      ],
    );
  }

  Widget _buildGroupRow(BuildContext context, String group) {
    final items = consonants.where((c) => c.koreanGroup == group).toList();
    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 48.0,
            child: Text(
              group,
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                for (final c in items) _ConsonantBadge(consonant: c, tts: tts),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(radius: 7.0, backgroundColor: color),
        const SizedBox(width: 6.0),
        Text(label, style: const TextStyle(fontSize: 12.0)),
      ],
    );
  }
}

class _ConsonantBadge extends StatelessWidget {
  const _ConsonantBadge({required this.consonant, required this.tts});

  final Consonant consonant;
  final TtsService tts;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ConsonantDetailScreen(consonant: consonant, tts: tts),
          ),
        );
      },
      child: CircleAvatar(
        radius: 24.0,
        backgroundColor: consonant.consonantClass.backgroundColor,
        child: Text(
          consonant.char,
          style: TextStyle(
            fontSize: 22.0,
            color: consonant.consonantClass.foregroundColor,
          ),
        ),
      ),
    );
  }
}
