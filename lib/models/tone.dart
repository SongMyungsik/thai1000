import '../data/consonants_data.dart';
import '../data/vowels_data.dart';
import 'consonant.dart';
import 'vowel.dart';
import 'word.dart';

enum Tone { mid, low, falling, high, rising }

extension ToneInfo on Tone {
  String get label => switch (this) {
    Tone.mid => '평성 (사만)',
    Tone.low => '낮은 성조 (에익)',
    Tone.falling => '떨어지는 성조 (토)',
    Tone.high => '높은 성조 (뜨리)',
    Tone.rising => '올라가는 성조 (짜따와)',
  };

  String get arrow => switch (this) {
    Tone.mid => '→',
    Tone.low => '↓',
    Tone.falling => '↘',
    Tone.high => '↑',
    Tone.rising => '↗',
  };

  String get description => switch (this) {
    Tone.mid => '평평하게 유지되는 중간 높이의 음',
    Tone.low => '낮게 깔리는 음',
    Tone.falling => '높은 데서 시작해 뚝 떨어지는 음',
    Tone.high => '높고 팽팽하게 유지되는 음',
    Tone.rising => '낮았다가 끝을 올리는 음',
  };

  /// 음절 진행(t: 0~1)에 따른 음높이(pitch: 0=가장 낮음, 1=가장 높음) 좌표.
  /// 태국어 교재의 표준 성조 그림과 같은 굴곡을 직선 구간으로 단순화했다.
  List<(double t, double pitch)> get contourPoints => switch (this) {
    Tone.mid => const [(0.0, 0.5), (1.0, 0.5)],
    Tone.low => const [(0.0, 0.35), (1.0, 0.15)],
    Tone.falling => const [(0.0, 0.9), (1.0, 0.1)],
    Tone.high => const [(0.0, 0.55), (1.0, 0.85)],
    Tone.rising => const [(0.0, 0.4), (0.4, 0.15), (1.0, 0.85)],
  };
}

enum ToneMark { none, maiEk, maiTho, maiTri, maiChattawa }

extension ToneMarkInfo on ToneMark {
  String? get symbol => switch (this) {
    ToneMark.none => null,
    ToneMark.maiEk => '่',
    ToneMark.maiTho => '้',
    ToneMark.maiTri => '๊',
    ToneMark.maiChattawa => '๋',
  };

  String get label => switch (this) {
    ToneMark.none => '없음',
    ToneMark.maiEk => '◌่ (마이 에익)',
    ToneMark.maiTho => '◌้ (마이 토)',
    ToneMark.maiTri => '◌๊ (마이 뜨리)',
    ToneMark.maiChattawa => '◌๋ (마이 짜따와)',
  };
}

const _maiEkChar = '่';
const _maiThoChar = '้';
const _maiTriChar = '๊';
const _maiChattawaChar = '๋';

/// 태국어 문자열에서 성조 부호를 찾아낸다. 기존 단어 데이터의 syllableText를
/// 그대로 재사용하기 위한 유틸이라 새 필드를 추가할 필요가 없다.
ToneMark extractToneMark(String text) {
  if (text.contains(_maiThoChar)) return ToneMark.maiTho;
  if (text.contains(_maiTriChar)) return ToneMark.maiTri;
  if (text.contains(_maiChattawaChar)) return ToneMark.maiChattawa;
  if (text.contains(_maiEkChar)) return ToneMark.maiEk;
  return ToneMark.none;
}

/// 받침 종류·모음 길이로 생음절/사음절을 계산한다. ก ข ค 같은 정지음 받침(k/t/p)만
/// 사음절이고, 받침이 없으면 모음 길이로 판정한다. 특수모음(ำ/ไ/ใ/เ...า)은 생음절로 취급.
bool isLiveSyllableFor(WordSyllablePart part) {
  if (part.finalConsonantChar != null) {
    final finalConsonant = consonants.firstWhere(
      (c) => c.char == part.finalConsonantChar,
    );
    return switch (finalConsonant.finalGroup) {
      FinalSoundGroup.k || FinalSoundGroup.t || FinalSoundGroup.p => false,
      _ => true,
    };
  }
  if (part.vowelDisplayForm != null) {
    final vowel = vowels.firstWhere(
      (v) => v.displayForm == part.vowelDisplayForm,
    );
    return vowel.length != VowelLength.short;
  }
  // 모음 기호가 없는 내재모음 음절은 항상 짧은 모음이라 사음절이다.
  return false;
}

/// low class 사음절의 성조는 모음 장단에 따라 갈리므로 별도로 판정한다.
/// 받침이 있으면(사음절) 모음 자체의 장단을, 모음 정보가 없는 내재모음이면
/// 항상 짧은 모음으로 취급한다.
bool isLongVowelFor(WordSyllablePart part) {
  if (part.vowelDisplayForm == null) return false;
  final vowel = vowels.firstWhere(
    (v) => v.displayForm == part.vowelDisplayForm,
  );
  return vowel.length == VowelLength.long;
}

Tone calculateTone({
  required ConsonantClass consonantClass,
  required bool isLiveSyllable,
  required bool isLongVowel,
  required ToneMark mark,
}) {
  switch (mark) {
    case ToneMark.maiEk:
      return consonantClass == ConsonantClass.low ? Tone.falling : Tone.low;
    case ToneMark.maiTho:
      return consonantClass == ConsonantClass.low ? Tone.high : Tone.falling;
    case ToneMark.maiTri:
      return Tone.high;
    case ToneMark.maiChattawa:
      return Tone.rising;
    case ToneMark.none:
      switch (consonantClass) {
        case ConsonantClass.mid:
          return isLiveSyllable ? Tone.mid : Tone.low;
        case ConsonantClass.high:
          return isLiveSyllable ? Tone.rising : Tone.low;
        case ConsonantClass.low:
          if (isLiveSyllable) return Tone.mid;
          return isLongVowel ? Tone.falling : Tone.high;
      }
  }
}

/// 단어 음절 하나의 최종 성조. 선행 ห 등으로 성조 판정용 클래스가 실제
/// 발음 자음과 다를 때는 [WordSyllablePart.effectiveClassOverride]를 우선한다.
Tone toneOfSyllable(WordSyllablePart part) {
  final consonantClass =
      part.effectiveClassOverride ??
      consonants.firstWhere((c) => c.char == part.initialConsonantChar).consonantClass;
  return calculateTone(
    consonantClass: consonantClass,
    isLiveSyllable: isLiveSyllableFor(part),
    isLongVowel: isLongVowelFor(part),
    mark: extractToneMark(part.syllableText),
  );
}
