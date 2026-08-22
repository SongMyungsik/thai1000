import 'consonant.dart';

enum WordCategory {
  greetings,
  numbers,
  family,
  food,
  animals,
  colors,
  time,
  objects,
}

extension WordCategoryLabel on WordCategory {
  String get label => switch (this) {
    WordCategory.greetings => '인사말',
    WordCategory.numbers => '숫자',
    WordCategory.family => '가족',
    WordCategory.food => '음식',
    WordCategory.animals => '동물',
    WordCategory.colors => '색깔',
    WordCategory.time => '시간·요일',
    WordCategory.objects => '일상 사물',
  };
}

/// 한 음절을 이루는 자음/모음 조각. char·displayForm은 각각
/// [Consonant.char], [Vowel.displayForm]과 정확히 일치해야 상세 화면으로 연결된다.
class WordSyllablePart {
  final String? initialConsonantChar;
  final String? vowelDisplayForm;
  final String? finalConsonantChar;
  final String syllableText;
  final String syllableRoman;
  final String? note;

  /// 선행 ห(예: หมู, หนึ่ง)처럼 성조 판정용 자음 클래스가 실제 발음되는
  /// initialConsonantChar의 클래스와 다를 때만 채운다.
  final ConsonantClass? effectiveClassOverride;

  const WordSyllablePart({
    this.initialConsonantChar,
    this.vowelDisplayForm,
    this.finalConsonantChar,
    required this.syllableText,
    required this.syllableRoman,
    this.note,
    this.effectiveClassOverride,
  });
}

class Word {
  final String thai;
  final String romanization;
  final String meaningKorean;
  final WordCategory category;
  final List<WordSyllablePart> syllables;

  const Word({
    required this.thai,
    required this.romanization,
    required this.meaningKorean,
    required this.category,
    required this.syllables,
  });
}
