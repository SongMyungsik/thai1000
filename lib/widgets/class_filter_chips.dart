import 'package:flutter/material.dart';

/// 단일 선택 필터 칩 목록. index 0은 항상 "전체"로 사용한다.
class ClassFilterChips extends StatelessWidget {
  const ClassFilterChips({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
    this.selectedColors,
    this.selectedLabelColors,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  /// index별 선택 시 배경색(옵션). 넘기지 않으면 기존 테마 색을 그대로 쓴다.
  final List<Color?>? selectedColors;

  /// index별 선택 시 글자색(옵션). [selectedColors]와 같은 길이로 넘긴다.
  final List<Color?>? selectedLabelColors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        itemCount: labels.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8.0),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          final color = selectedColors?[index];
          final labelColor = selectedLabelColors?[index];
          return ChoiceChip(
            label: Text(labels[index]),
            selected: isSelected,
            onSelected: (_) => onSelected(index),
            selectedColor: isSelected ? color : null,
            labelStyle: isSelected && labelColor != null
                ? TextStyle(color: labelColor)
                : null,
          );
        },
      ),
    );
  }
}
