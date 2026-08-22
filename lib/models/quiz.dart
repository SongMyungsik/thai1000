class QuizQuestion {
  /// 짧은 질문 문구. 예: "이 자음의 이름은?"
  final String hint;

  /// 문제의 중심이 되는 큰 글씨 표시 대상. 예: 'ก', '◌ือ', '조건 설명'.
  final String prompt;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const QuizQuestion({
    required this.hint,
    required this.prompt,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });

  String get correctAnswer => options[correctIndex];
}
