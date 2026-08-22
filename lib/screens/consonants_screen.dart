import 'package:flutter/material.dart';

import '../data/consonants_data.dart';
import '../models/consonant.dart';
import '../services/tts_service.dart';
import '../widgets/class_filter_chips.dart';
import '../widgets/letter_grid_tile.dart';
import 'consonant_detail_screen.dart';

const _consonantFilterLabels = ['전체', '중자음', '고자음', '저자음'];

/// 자음 필터 칩 + 그리드. Scaffold/AppBar 없이 바디만 반환해서
/// "자음모음" 탭의 서브탭 바디로 바로 끼워 넣을 수 있게 했다.
class ConsonantsTabBody extends StatefulWidget {
  const ConsonantsTabBody({super.key, required this.tts});

  final TtsService tts;

  @override
  State<ConsonantsTabBody> createState() => _ConsonantsTabBodyState();
}

class _ConsonantsTabBodyState extends State<ConsonantsTabBody> {
  int _filterIndex = 0;

  List<Consonant> get _filteredConsonants {
    if (_filterIndex == 0) return consonants;
    final targetClass = ConsonantClass.values[_filterIndex - 1];
    return consonants.where((c) => c.consonantClass == targetClass).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClassFilterChips(
          labels: _consonantFilterLabels,
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
            itemCount: _filteredConsonants.length,
            itemBuilder: (context, index) {
              final consonant = _filteredConsonants[index];
              return LetterGridTile(
                mainText: consonant.char,
                subText: consonant.romanName,
                badgeText: consonant.consonantClass.shortLabel,
                boxColor: consonant.consonantClass.backgroundColor,
                boxTextColor: consonant.consonantClass.foregroundColor,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ConsonantDetailScreen(
                        consonant: consonant,
                        tts: widget.tts,
                      ),
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
