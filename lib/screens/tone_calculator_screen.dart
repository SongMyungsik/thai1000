import 'package:flutter/material.dart';

import '../models/consonant.dart';
import '../models/tone.dart';
import '../widgets/class_filter_chips.dart';
import '../widgets/tone_contour_chart.dart';

enum _SyllableChoice { live, deadShort, deadLong }

const _classLabels = ['중자음', '고자음', '저자음'];
const _syllableLabels = ['생음절', '사음절 (짧은 모음)', '사음절 (긴 모음)'];

class ToneCalculatorScreen extends StatefulWidget {
  const ToneCalculatorScreen({super.key});

  @override
  State<ToneCalculatorScreen> createState() => _ToneCalculatorScreenState();
}

class _ToneCalculatorScreenState extends State<ToneCalculatorScreen> {
  ConsonantClass _consonantClass = ConsonantClass.mid;
  _SyllableChoice _syllableChoice = _SyllableChoice.live;
  ToneMark _mark = ToneMark.none;

  @override
  Widget build(BuildContext context) {
    final isLive = _syllableChoice == _SyllableChoice.live;
    final isLongVowel = _syllableChoice == _SyllableChoice.deadLong;
    final tone = calculateTone(
      consonantClass: _consonantClass,
      isLiveSyllable: isLive,
      isLongVowel: isLongVowel,
      mark: _mark,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('성조 계산기')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text('① 자음 클래스', style: Theme.of(context).textTheme.titleSmall),
          ClassFilterChips(
            labels: _classLabels,
            selectedIndex: ConsonantClass.values.indexOf(_consonantClass),
            selectedColors: ConsonantClass.values
                .map((c) => c.backgroundColor)
                .toList(),
            selectedLabelColors: ConsonantClass.values
                .map((c) => c.foregroundColor)
                .toList(),
            onSelected: (i) => setState(() {
              _consonantClass = ConsonantClass.values[i];
              if (_consonantClass != ConsonantClass.mid &&
                  (_mark == ToneMark.maiTri || _mark == ToneMark.maiChattawa)) {
                _mark = ToneMark.none;
              }
            }),
          ),
          const SizedBox(height: 16.0),
          Text('② 음절 유형', style: Theme.of(context).textTheme.titleSmall),
          ClassFilterChips(
            labels: _syllableLabels,
            selectedIndex: _SyllableChoice.values.indexOf(_syllableChoice),
            onSelected: (i) =>
                setState(() => _syllableChoice = _SyllableChoice.values[i]),
          ),
          const SizedBox(height: 16.0),
          Text('③ 성조 부호', style: Theme.of(context).textTheme.titleSmall),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              for (final m in ToneMark.values)
                ChoiceChip(
                  label: Text(m.label),
                  selected: _mark == m,
                  onSelected: _isMarkAllowed(m)
                      ? (_) => setState(() => _mark = m)
                      : null,
                ),
            ],
          ),
          const SizedBox(height: 32.0),
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  ToneContourChart(tone: tone, width: 160.0, height: 100.0, strokeWidth: 4.0),
                  const SizedBox(height: 8.0),
                  Text(
                    tone.label,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8.0),
                  Text(tone.description, textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isMarkAllowed(ToneMark m) {
    if (m == ToneMark.maiTri || m == ToneMark.maiChattawa) {
      return _consonantClass == ConsonantClass.mid;
    }
    return true;
  }
}
