// Pure unit tests for the tone rule engine — no widgets involved, so these
// verify the actual Thai tone rule table directly.

import 'package:flutter_test/flutter_test.dart';
import 'package:thai1000/models/consonant.dart';
import 'package:thai1000/models/tone.dart';

void main() {
  group('contourPoints', () {
    test('every tone has at least 2 points spanning t=0 to t=1', () {
      for (final tone in Tone.values) {
        final points = tone.contourPoints;
        expect(points.length, greaterThanOrEqualTo(2));
        expect(points.first.$1, 0.0);
        expect(points.last.$1, 1.0);
        for (final (t, pitch) in points) {
          expect(t, inInclusiveRange(0.0, 1.0));
          expect(pitch, inInclusiveRange(0.0, 1.0));
        }
      }
    });
  });

  group('extractToneMark', () {
    test('finds each mark inside a syllable string', () {
      expect(extractToneMark('ไม่'), ToneMark.maiEk);
      expect(extractToneMark('เก้า'), ToneMark.maiTho);
      expect(extractToneMark('ก๊า'), ToneMark.maiTri);
      expect(extractToneMark('ก๋า'), ToneMark.maiChattawa);
      expect(extractToneMark('มา'), ToneMark.none);
    });
  });

  group('calculateTone — no mark', () {
    test('mid class', () {
      expect(
        calculateTone(
          consonantClass: ConsonantClass.mid,
          isLiveSyllable: true,
          isLongVowel: true,
          mark: ToneMark.none,
        ),
        Tone.mid,
      );
      expect(
        calculateTone(
          consonantClass: ConsonantClass.mid,
          isLiveSyllable: false,
          isLongVowel: true,
          mark: ToneMark.none,
        ),
        Tone.low,
      );
      expect(
        calculateTone(
          consonantClass: ConsonantClass.mid,
          isLiveSyllable: false,
          isLongVowel: false,
          mark: ToneMark.none,
        ),
        Tone.low,
      );
    });

    test('high class', () {
      expect(
        calculateTone(
          consonantClass: ConsonantClass.high,
          isLiveSyllable: true,
          isLongVowel: true,
          mark: ToneMark.none,
        ),
        Tone.rising,
      );
      expect(
        calculateTone(
          consonantClass: ConsonantClass.high,
          isLiveSyllable: false,
          isLongVowel: false,
          mark: ToneMark.none,
        ),
        Tone.low,
      );
    });

    test('low class splits dead syllables by vowel length', () {
      expect(
        calculateTone(
          consonantClass: ConsonantClass.low,
          isLiveSyllable: true,
          isLongVowel: true,
          mark: ToneMark.none,
        ),
        Tone.mid,
      );
      expect(
        calculateTone(
          consonantClass: ConsonantClass.low,
          isLiveSyllable: false,
          isLongVowel: false,
          mark: ToneMark.none,
        ),
        Tone.high,
      );
      expect(
        calculateTone(
          consonantClass: ConsonantClass.low,
          isLiveSyllable: false,
          isLongVowel: true,
          mark: ToneMark.none,
        ),
        Tone.falling,
      );
    });
  });

  group('calculateTone — with mark', () {
    test('mai ek: low class flips to falling, others go low', () {
      expect(
        calculateTone(
          consonantClass: ConsonantClass.mid,
          isLiveSyllable: true,
          isLongVowel: true,
          mark: ToneMark.maiEk,
        ),
        Tone.low,
      );
      expect(
        calculateTone(
          consonantClass: ConsonantClass.high,
          isLiveSyllable: true,
          isLongVowel: true,
          mark: ToneMark.maiEk,
        ),
        Tone.low,
      );
      expect(
        calculateTone(
          consonantClass: ConsonantClass.low,
          isLiveSyllable: true,
          isLongVowel: true,
          mark: ToneMark.maiEk,
        ),
        Tone.falling,
      );
    });

    test('mai tho: low class flips to high, others go falling', () {
      expect(
        calculateTone(
          consonantClass: ConsonantClass.mid,
          isLiveSyllable: true,
          isLongVowel: true,
          mark: ToneMark.maiTho,
        ),
        Tone.falling,
      );
      expect(
        calculateTone(
          consonantClass: ConsonantClass.high,
          isLiveSyllable: true,
          isLongVowel: true,
          mark: ToneMark.maiTho,
        ),
        Tone.falling,
      );
      expect(
        calculateTone(
          consonantClass: ConsonantClass.low,
          isLiveSyllable: true,
          isLongVowel: true,
          mark: ToneMark.maiTho,
        ),
        Tone.high,
      );
    });

    test('mai tri always high, mai chattawa always rising', () {
      expect(
        calculateTone(
          consonantClass: ConsonantClass.mid,
          isLiveSyllable: true,
          isLongVowel: true,
          mark: ToneMark.maiTri,
        ),
        Tone.high,
      );
      expect(
        calculateTone(
          consonantClass: ConsonantClass.mid,
          isLiveSyllable: true,
          isLongVowel: true,
          mark: ToneMark.maiChattawa,
        ),
        Tone.rising,
      );
    });
  });
}
