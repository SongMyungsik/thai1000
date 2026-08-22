import 'dart:math';

import '../data/consonants_data.dart';
import '../data/vowels_data.dart';
import '../data/words_data.dart';
import '../models/consonant.dart';
import '../models/quiz.dart';
import '../models/tone.dart';
import '../models/vowel.dart';

const _consonantClassLabels = ['중자음', '고자음', '저자음'];
const _vowelGroupLabels = ['단모음', '이중모음', '특수모음'];

List<String> _pickDistractorTexts(
  List<String> allTexts,
  String correctText,
  int n,
  Random rng,
) {
  final pool = allTexts.where((t) => t != correctText).toSet().toList();
  pool.shuffle(rng);
  return pool.take(n).toList();
}

List<QuizQuestion> generateConsonantQuiz({int count = 10}) {
  final rng = Random();
  final chosen = (List.of(consonants)..shuffle(rng)).take(count).toList();
  final allNames = consonants.map((c) => c.romanName).toList();

  return chosen.map((c) {
    if (rng.nextBool()) {
      final correctText = c.consonantClass.label;
      final options = (List<String>.from(_consonantClassLabels)..shuffle(rng));
      return QuizQuestion(
        hint: '이 자음의 클래스는 무엇일까요?',
        prompt: c.char,
        options: options,
        correctIndex: options.indexOf(correctText),
        explanation: '${c.char}(${c.romanName})는 ${c.consonantClass.label}입니다.',
      );
    }
    final correctText = c.romanName;
    final distractors = _pickDistractorTexts(allNames, correctText, 3, rng);
    final options = [correctText, ...distractors]..shuffle(rng);
    return QuizQuestion(
      hint: '이 자음의 이름은 무엇일까요?',
      prompt: c.char,
      options: options,
      correctIndex: options.indexOf(correctText),
      explanation:
          '${c.char}는 ${c.romanName}(${c.koreanName}), ${c.consonantClass.label}입니다.',
    );
  }).toList();
}

List<QuizQuestion> generateVowelQuiz({int count = 10}) {
  final rng = Random();
  final chosen = (List.of(vowels)..shuffle(rng)).take(count).toList();
  final allRomanizations = vowels.map((v) => v.romanization).toList();

  return chosen.map((v) {
    if (rng.nextBool()) {
      final correctText = v.group.label;
      final options = (List<String>.from(_vowelGroupLabels)..shuffle(rng));
      return QuizQuestion(
        hint: '이 모음은 어떤 종류일까요?',
        prompt: v.displayForm,
        options: options,
        correctIndex: options.indexOf(correctText),
        explanation: '${v.displayForm}(${v.name})는 ${v.group.label}입니다.',
      );
    }
    final correctText = v.romanization;
    final distractors = _pickDistractorTexts(allRomanizations, correctText, 3, rng);
    final options = [correctText, ...distractors]..shuffle(rng);
    return QuizQuestion(
      hint: '이 모음의 로마자 발음은?',
      prompt: v.displayForm,
      options: options,
      correctIndex: options.indexOf(correctText),
      explanation:
          '${v.displayForm}(${v.name})는 "${v.romanization}"로 읽습니다 (${v.koreanApprox}).',
    );
  }).toList();
}

List<QuizQuestion> generateWordQuiz({int count = 10}) {
  final rng = Random();
  final chosen = (List.of(words)..shuffle(rng)).take(count).toList();
  final allMeanings = words.map((w) => w.meaningKorean).toList();
  final allThai = words.map((w) => w.thai).toList();

  return chosen.map((w) {
    if (rng.nextBool()) {
      final correctText = w.meaningKorean;
      final distractors = _pickDistractorTexts(allMeanings, correctText, 3, rng);
      final options = [correctText, ...distractors]..shuffle(rng);
      return QuizQuestion(
        hint: '이 단어의 뜻은?',
        prompt: '${w.thai} (${w.romanization})',
        options: options,
        correctIndex: options.indexOf(correctText),
        explanation: '${w.thai}(${w.romanization})는 "${w.meaningKorean}"라는 뜻입니다.',
      );
    }
    final correctText = w.thai;
    final distractors = _pickDistractorTexts(allThai, correctText, 3, rng);
    final options = [correctText, ...distractors]..shuffle(rng);
    return QuizQuestion(
      hint: '"${w.meaningKorean}"에 해당하는 태국어 단어는?',
      prompt: w.meaningKorean,
      options: options,
      correctIndex: options.indexOf(correctText),
      explanation: '"${w.meaningKorean}"는 ${w.thai}(${w.romanization})입니다.',
    );
  }).toList();
}

List<QuizQuestion> generateToneQuiz({int count = 10}) {
  final rng = Random();
  final combos = <(ConsonantClass, bool, bool, ToneMark)>[];
  for (final cls in ConsonantClass.values) {
    for (final syllable in [(true, false), (false, false), (false, true)]) {
      for (final mark in ToneMark.values) {
        final isMidOnlyMark =
            mark == ToneMark.maiTri || mark == ToneMark.maiChattawa;
        if (isMidOnlyMark && cls != ConsonantClass.mid) continue;
        combos.add((cls, syllable.$1, syllable.$2, mark));
      }
    }
  }
  combos.shuffle(rng);
  final chosen = combos.take(count).toList();

  return chosen.map((combo) {
    final (cls, isLive, isLong, mark) = combo;
    final correctTone = calculateTone(
      consonantClass: cls,
      isLiveSyllable: isLive,
      isLongVowel: isLong,
      mark: mark,
    );
    final options = (Tone.values.map((t) => t.label).toList()..shuffle(rng));
    final syllableDesc = isLive
        ? '생음절'
        : (isLong ? '사음절(긴 모음)' : '사음절(짧은 모음)');
    final markDesc = mark == ToneMark.none ? '부호 없음' : mark.label;

    return QuizQuestion(
      hint: '이 조건의 성조는 무엇일까요?',
      prompt: '${cls.label} · $syllableDesc · $markDesc',
      options: options,
      correctIndex: options.indexOf(correctTone.label),
      explanation:
          '${cls.label} + $syllableDesc + $markDesc → ${correctTone.arrow} ${correctTone.label}',
    );
  }).toList();
}
