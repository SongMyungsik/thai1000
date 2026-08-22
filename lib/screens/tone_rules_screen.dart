import 'package:flutter/material.dart';

import '../models/consonant.dart';
import '../models/tone.dart';
import '../widgets/tone_contour_chart.dart';

class ToneRulesScreen extends StatelessWidget {
  const ToneRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('성조 규칙표')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            '성조 부호가 없을 때',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8.0),
          _RulesTable(
            headers: const ['자음 클래스', '생음절', '사음절(짧은 모음)', '사음절(긴 모음)'],
            rowClasses: const [ConsonantClass.mid, ConsonantClass.high, ConsonantClass.low],
            rows: [
              ['중자음', Tone.mid.label, Tone.low.label, Tone.low.label],
              ['고자음', Tone.rising.label, Tone.low.label, Tone.low.label],
              ['저자음', Tone.mid.label, Tone.high.label, Tone.falling.label],
            ],
          ),
          const SizedBox(height: 24.0),
          Text('성조 부호가 있을 때', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4.0),
          Text(
            '저자음은 중자음·고자음과 반대로 뒤집힌다는 점에 주의하세요. ๊·๋는 저자음·고자음 글자에는 쓰이지 않습니다.',
            style: TextStyle(color: Theme.of(context).colorScheme.outline),
          ),
          const SizedBox(height: 8.0),
          _RulesTable(
            headers: const ['자음 클래스', '◌่', '◌้', '◌๊', '◌๋'],
            rowClasses: const [ConsonantClass.mid, ConsonantClass.high, ConsonantClass.low],
            rows: [
              ['중자음', Tone.low.label, Tone.falling.label, Tone.high.label, Tone.rising.label],
              ['고자음', Tone.low.label, Tone.falling.label, '(쓰지 않음)', '(쓰지 않음)'],
              ['저자음', Tone.falling.label, Tone.high.label, '(쓰지 않음)', '(쓰지 않음)'],
            ],
          ),
          const SizedBox(height: 24.0),
          Text('5개 성조', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8.0),
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
        ],
      ),
    );
  }
}

class _RulesTable extends StatelessWidget {
  const _RulesTable({required this.headers, required this.rows, this.rowClasses});

  final List<String> headers;
  final List<List<String>> rows;

  /// rows와 같은 순서의 자음 클래스. 첫 번째 셀(자음 클래스 이름)을 그 색으로 칠한다.
  final List<ConsonantClass>? rowClasses;

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).colorScheme.outlineVariant;
    return Table(
      border: TableBorder.all(color: borderColor),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest),
          children: [
            for (final h in headers) _cell(h, bold: true),
          ],
        ),
        for (var i = 0; i < rows.length; i++)
          TableRow(
            children: [
              for (var j = 0; j < rows[i].length; j++)
                _cell(
                  rows[i][j],
                  backgroundColor: j == 0 ? _classColorAt(i)?.backgroundColor : null,
                  textColor: j == 0 ? _classColorAt(i)?.foregroundColor : null,
                ),
            ],
          ),
      ],
    );
  }

  ConsonantClass? _classColorAt(int rowIndex) {
    final classes = rowClasses;
    if (classes == null || rowIndex >= classes.length) return null;
    return classes[rowIndex];
  }

  Widget _cell(
    String text, {
    bool bold = false,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          fontSize: 12.5,
          color: textColor,
        ),
      ),
    );
  }
}
