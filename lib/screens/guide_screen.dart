import 'package:flutter/material.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      appBar: AppBar(title: const Text('학습 가이드')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text('자음 클래스(중자음·고자음·저자음)란?', style: titleStyle),
          const SizedBox(height: 8.0),
          const Text(
            '태국어 자음은 중자음, 고자음, 저자음 세 그룹으로 나뉩니다. 이 분류 자체가 소리를 바꾸지는 않지만, '
            '같은 모음이라도 어떤 클래스의 자음으로 시작하느냐에 따라 단어의 성조(음의 높낮이)가 달라지기 때문에 '
            '태국어 문법에서 매우 중요하게 다룹니다. 이 앱에서는 우선 각 글자의 클래스를 눈에 익히는 데 집중하고, '
            '성조 규칙 자체는 다루지 않습니다.',
          ),
          const SizedBox(height: 20.0),
          Text('받침(종성)이란?', style: titleStyle),
          const SizedBox(height: 8.0),
          const Text(
            '태국어 자음은 단어 맨 앞(초성)에 올 때와 단어 끝(받침, 종성)에 올 때 소리가 다르게 나는 경우가 많습니다. '
            '예를 들어 ก은 초성에서는 "k"에 가깝게 발음되지만, 받침으로 쓰여도 "-k"로 똑같이 막히는 소리가 나는 반면, '
            'ท 같은 글자는 초성에서는 "th"(격음)로 발음되다가 받침에서는 "-t"로 단순화됩니다. '
            '또한 ฉ, ผ, ฝ, ห, อ, ฮ 여섯 글자는 아예 받침으로 쓰이지 않습니다. '
            '각 자음 상세 화면의 "종성(받침)일 때 소리" 항목에서 이 규칙을 하나씩 확인할 수 있습니다.',
          ),
          const SizedBox(height: 20.0),
          Text('모음은 왜 자리마다 위치가 다른가요?', style: titleStyle),
          const SizedBox(height: 8.0),
          const Text(
            '한국어와 달리 태국어 모음 기호는 자음의 앞, 뒤, 위, 아래, 또는 앞뒤로 감싸는 형태로 붙습니다. '
            '이 앱에서는 자음이 올 자리를 ◌ 기호로 표시해서(예: เ◌ = 자음 앞에 오는 장모음 에), '
            '실제 글자를 조합했을 때 어디에 위치하는지 미리 감을 잡을 수 있게 했습니다.',
          ),
          const SizedBox(height: 20.0),
          Text('알아두면 좋은 점', style: titleStyle),
          const SizedBox(height: 8.0),
          const Text(
            '이 앱은 발음 재생에 기기(휴대폰/PC)에 설치된 태국어 음성 엔진을 사용합니다. '
            '기기에 태국어(th-TH) 음성이 설치되어 있지 않으면 소리가 나지 않을 수 있으니, '
            '이 경우 화면에 표기된 로마자·한글 근사음을 참고해 주세요. '
            '또한 옛 자음 ฃ, ฅ는 오늘날 쓰이지 않아 이 앱의 목록에서 제외했습니다.',
          ),
        ],
      ),
    );
  }
}
