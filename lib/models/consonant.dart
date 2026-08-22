import 'package:flutter/material.dart';

/// 자음 클래스(자음의 성조 그룹). 태국어 성조 규칙의 기초가 되는 분류다.
enum ConsonantClass { mid, high, low }

extension ConsonantClassLabel on ConsonantClass {
  String get label => switch (this) {
    ConsonantClass.mid => '중자음',
    ConsonantClass.high => '고자음',
    ConsonantClass.low => '저자음',
  };

  String get shortLabel => switch (this) {
    ConsonantClass.mid => '중',
    ConsonantClass.high => '고',
    ConsonantClass.low => '저',
  };
}

/// 자음 클래스를 색으로 구분한다: 고자음=빨강, 중자음=초록, 저자음=파랑.
extension ConsonantClassColor on ConsonantClass {
  Color get backgroundColor => switch (this) {
    ConsonantClass.high => Colors.red.shade100,
    ConsonantClass.mid => Colors.green.shade100,
    ConsonantClass.low => Colors.blue.shade100,
  };

  Color get foregroundColor => switch (this) {
    ConsonantClass.high => Colors.red.shade900,
    ConsonantClass.mid => Colors.green.shade900,
    ConsonantClass.low => Colors.blue.shade900,
  };
}

/// 받침(종성)으로 쓰일 때 실제로 나는 소리의 그룹(มาตราตัวสะกด).
enum FinalSoundGroup { k, t, p, ng, n, m, y, w, none }

extension FinalSoundGroupInfo on FinalSoundGroup {
  /// 받침일 때 소리를 나타내는 로마자 표기. 받침으로 쓰이지 않으면 null.
  String? get romanSuffix => switch (this) {
    FinalSoundGroup.k => '-k',
    FinalSoundGroup.t => '-t',
    FinalSoundGroup.p => '-p',
    FinalSoundGroup.ng => '-ng',
    FinalSoundGroup.n => '-n',
    FinalSoundGroup.m => '-m',
    FinalSoundGroup.y => '-y',
    FinalSoundGroup.w => '-w',
    FinalSoundGroup.none => null,
  };

  /// 한국어 화자가 감을 잡기 쉬운 근사 설명.
  String get koreanDescription => switch (this) {
    FinalSoundGroup.k => "한국어 'ㄱ' 받침처럼 목 안에서 막히는 소리 (예: '악')",
    FinalSoundGroup.t => "한국어 'ㄷ/ㅅ' 받침처럼 혀끝이 막히는 소리 (예: '앋')",
    FinalSoundGroup.p => "한국어 'ㅂ' 받침처럼 입술이 닫히는 소리 (예: '압')",
    FinalSoundGroup.ng => "한국어 'ㅇ' 받침 소리 (예: '앙')",
    FinalSoundGroup.n => "한국어 'ㄴ' 받침 소리 (예: '안')",
    FinalSoundGroup.m => "한국어 'ㅁ' 받침 소리 (예: '암')",
    FinalSoundGroup.y => "모음 뒤에 살짝 'ㅣ'가 붙는 소리 (예: '아이')",
    FinalSoundGroup.w => "모음 뒤에 살짝 'ㅜ'가 붙는 소리 (예: '아우')",
    FinalSoundGroup.none => '받침(종성)으로 쓰이지 않는 글자',
  };
}

class Consonant {
  final String char;
  final String romanName;
  final String koreanName;
  final ConsonantClass consonantClass;
  final String initialSoundRoman;
  final String initialSoundKorean;
  final FinalSoundGroup finalGroup;
  final String exampleWord;
  final String exampleWordRoman;
  final String exampleMeaning;

  /// 발음이 가장 가까운 한글 자음 그룹 라벨(예: 'ㄷ', 'ㅅ/ㅆ', 'ㅇ'). "한글순" 탭 정렬용.
  final String koreanGroup;

  const Consonant({
    required this.char,
    required this.romanName,
    required this.koreanName,
    required this.consonantClass,
    required this.initialSoundRoman,
    required this.initialSoundKorean,
    required this.finalGroup,
    required this.exampleWord,
    required this.exampleWordRoman,
    required this.exampleMeaning,
    required this.koreanGroup,
  });
}
