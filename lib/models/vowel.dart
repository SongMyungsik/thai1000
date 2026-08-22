import 'package:flutter/material.dart';

enum VowelLength { short, long, special }

extension VowelLengthLabel on VowelLength {
  String get label => switch (this) {
    VowelLength.short => '단(短)',
    VowelLength.long => '장(長)',
    VowelLength.special => '특수',
  };
}

/// 필터링용 큰 분류: 단순모음/이중모음/특수모음.
enum VowelGroup { monophthong, diphthong, special }

extension VowelGroupLabel on VowelGroup {
  String get label => switch (this) {
    VowelGroup.monophthong => '단모음',
    VowelGroup.diphthong => '이중모음',
    VowelGroup.special => '특수모음',
  };
}

/// 자음 클래스 색(red/green/blue)과 겹치지 않게 다른 3색으로 구분한다.
extension VowelGroupColor on VowelGroup {
  Color get backgroundColor => switch (this) {
    VowelGroup.monophthong => Colors.purple.shade100,
    VowelGroup.diphthong => Colors.orange.shade100,
    VowelGroup.special => Colors.brown.shade100,
  };

  Color get foregroundColor => switch (this) {
    VowelGroup.monophthong => Colors.purple.shade900,
    VowelGroup.diphthong => Colors.orange.shade900,
    VowelGroup.special => Colors.brown.shade900,
  };
}

class Vowel {
  /// 초성 자리를 ◌(U+25CC)로 표시한 모음 형태. 예: '◌ะ', 'เ◌'
  final String displayForm;

  /// ◌ 자리에 'ก'을 넣어 실제로 읽어볼 수 있게 만든 예시 음절. 예: 'กะ', 'เก'
  final String demoSyllable;

  final String name;
  final String romanization;
  final String koreanApprox;
  final VowelLength length;
  final VowelGroup group;
  final String exampleWord;
  final String exampleWordRoman;
  final String exampleMeaning;

  const Vowel({
    required this.displayForm,
    required this.demoSyllable,
    required this.name,
    required this.romanization,
    required this.koreanApprox,
    required this.length,
    required this.group,
    required this.exampleWord,
    required this.exampleWordRoman,
    required this.exampleMeaning,
  });
}
