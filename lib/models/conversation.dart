enum ConversationCategory {
  greetings,
  selfIntro,
  family,
  restaurant,
  shopping,
  directions,
  farewell,
}

extension ConversationCategoryLabel on ConversationCategory {
  String get label => switch (this) {
    ConversationCategory.greetings => '인사 나누기',
    ConversationCategory.selfIntro => '자기소개',
    ConversationCategory.family => '가족 소개',
    ConversationCategory.restaurant => '식당에서',
    ConversationCategory.shopping => '쇼핑',
    ConversationCategory.directions => '길 묻기·택시',
    ConversationCategory.farewell => '작별 인사',
  };
}

enum Speaker { a, b }

/// 대화 한 줄. relatedWords는 [Word.thai]와 정확히 일치하는 문자열만 담아서
/// 단어 상세 화면으로 바로 연결한다.
class DialogueLine {
  final Speaker speaker;
  final String thai;
  final String romanization;
  final String meaningKorean;
  final List<String> relatedWords;

  const DialogueLine({
    required this.speaker,
    required this.thai,
    required this.romanization,
    required this.meaningKorean,
    this.relatedWords = const [],
  });
}

class Dialogue {
  final String title;
  final ConversationCategory category;
  final List<DialogueLine> lines;

  const Dialogue({
    required this.title,
    required this.category,
    required this.lines,
  });
}
