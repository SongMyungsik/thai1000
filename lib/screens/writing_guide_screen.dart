import 'package:flutter/material.dart';

import '../widgets/counterclockwise_diagram.dart';

/// 태국어 자음 쓰기의 핵심 원칙을 설명하는 화면. 42개 글자 각각의 정밀한
/// 획순은 표준화된 자료가 없어 다루지 않고(추측으로 잘못 가르치는 위험을
/// 피하기 위함), 거의 모든 글자에 적용되는 확실한 보편 원칙만 안내한다.
class WritingGuideScreen extends StatelessWidget {
  const WritingGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('자음 쓰는 법')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            '핵심 원칙 한 가지',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12.0),
          const Text(
            '태국어 자음은 대부분 "머리(หัว)"라고 부르는 동그란 고리로 시작합니다. '
            '이 머리를 가장 먼저, 시계 반대 방향으로 그리고 나서 나머지 획'
            '(세로선·가로선·꼬리 등)을 자연스러운 순서로 이어서 씁니다.',
            style: TextStyle(fontSize: 15.0, height: 1.5),
          ),
          const SizedBox(height: 24.0),
          Center(
            child: Column(
              children: [
                const CounterclockwiseDiagram(),
                const SizedBox(height: 8.0),
                Text(
                  '머리(고리)를 그리는 방향',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
          Card(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '알아두면 좋은 점',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '글자마다 세부 획순은 학교나 교재에 따라 조금씩 다를 수 있습니다. '
                    '이 앱은 42개 글자 각각의 정밀한 획순 대신, 거의 모든 글자에 '
                    '공통으로 적용되는 이 원칙 하나를 정확하게 알려드리는 데 집중합니다. '
                    '이 원칙만 기억해도 대부분의 글자를 자연스럽게 쓸 수 있습니다.',
                    style: TextStyle(height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            '자음 목록에서 글자를 눌러 상세 화면으로 들어가면, 그 글자에 이 원칙을 '
            '적용한 짧은 힌트를 볼 수 있습니다.',
            style: TextStyle(fontSize: 13.0, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
