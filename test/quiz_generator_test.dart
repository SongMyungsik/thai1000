// Pure unit tests for the quiz generators — no widgets involved.

import 'package:flutter_test/flutter_test.dart';
import 'package:thai1000/models/consonant.dart';
import 'package:thai1000/models/quiz.dart';
import 'package:thai1000/models/tone.dart';
import 'package:thai1000/services/quiz_generator.dart';

void _checkWellFormed(List<QuizQuestion> questions, int expectedCount) {
  expect(questions.length, expectedCount);
  for (final q in questions) {
    expect(q.options.toSet().length, q.options.length, reason: 'options must be unique: ${q.options}');
    expect(q.correctIndex, inInclusiveRange(0, q.options.length - 1));
    expect(q.options[q.correctIndex], isNotEmpty);
    expect(q.hint, isNotEmpty);
    expect(q.explanation, isNotEmpty);
  }
}

void main() {
  test('generateConsonantQuiz returns well-formed questions', () {
    _checkWellFormed(generateConsonantQuiz(count: 15), 15);
  });

  test('generateVowelQuiz returns well-formed questions', () {
    _checkWellFormed(generateVowelQuiz(count: 15), 15);
  });

  test('generateWordQuiz returns well-formed questions', () {
    _checkWellFormed(generateWordQuiz(count: 15), 15);
  });

  test('generateToneQuiz returns well-formed questions with 5 tone options', () {
    final questions = generateToneQuiz(count: 15);
    _checkWellFormed(questions, 15);
    for (final q in questions) {
      expect(q.options.length, Tone.values.length);
      expect(q.options.toSet(), Tone.values.map((t) => t.label).toSet());
    }
  });

  test('generateToneQuiz never pairs mai tri/chattawa with non-mid class', () {
    // Run several times since combos are randomly shuffled/sampled.
    for (var i = 0; i < 20; i++) {
      final questions = generateToneQuiz(count: 33);
      for (final q in questions) {
        final usesTriOrChattawa =
            q.prompt.contains('◌๊') || q.prompt.contains('◌๋');
        if (usesTriOrChattawa) {
          expect(q.prompt, contains('중자음'));
        }
      }
    }
  });

  test('generateConsonantQuiz class options are always the fixed 3 classes', () {
    final questions = generateConsonantQuiz(count: 30);
    for (final q in questions) {
      if (q.hint.contains('클래스')) {
        expect(
          q.options.toSet(),
          ConsonantClass.values.map((c) => c.label).toSet(),
        );
      }
    }
  });
}
