import 'package:flutter/material.dart';

import '../data/vowels_data.dart';
import '../models/vowel.dart';
import '../services/tts_service.dart';
import '../widgets/class_filter_chips.dart';
import '../widgets/letter_grid_tile.dart';
import 'vowel_detail_screen.dart';

const _vowelFilterLabels = ['전체', '단모음', '이중모음', '특수모음'];

/// 모음 필터 칩 + 그리드. Scaffold/AppBar 없이 바디만 반환해서
/// "자음모음" 탭의 서브탭 바디로 바로 끼워 넣을 수 있게 했다.
class VowelsTabBody extends StatefulWidget {
  const VowelsTabBody({super.key, required this.tts});

  final TtsService tts;

  @override
  State<VowelsTabBody> createState() => _VowelsTabBodyState();
}

class _VowelsTabBodyState extends State<VowelsTabBody> {
  int _filterIndex = 0;

  List<Vowel> get _filteredVowels {
    if (_filterIndex == 0) return vowels;
    final targetGroup = VowelGroup.values[_filterIndex - 1];
    return vowels.where((v) => v.group == targetGroup).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClassFilterChips(
          labels: _vowelFilterLabels,
          selectedIndex: _filterIndex,
          onSelected: (i) => setState(() => _filterIndex = i),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.85,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: _filteredVowels.length,
            itemBuilder: (context, index) {
              final vowel = _filteredVowels[index];
              return LetterGridTile(
                mainText: vowel.displayForm,
                subText: vowel.romanization,
                badgeText: vowel.group.label,
                boxColor: vowel.group.backgroundColor,
                boxTextColor: vowel.group.foregroundColor,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          VowelDetailScreen(vowel: vowel, tts: widget.tts),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
