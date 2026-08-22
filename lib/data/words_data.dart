import '../models/consonant.dart';
import '../models/word.dart';

const _inheritedVowelNote = '표기된 모음 기호가 없지만 짧은 "오" 소리가 들어갑니다 (내재모음)';
const _leadingHoNote = 'ห는 소리 나지 않고 뒤 자음의 성조만 바꿔주는 역할을 합니다 (leading 어깨 부호 ห)';
const _shortEBeforeFinalNote = '받침 앞에서 짧은 모음을 나타내는 특수 부호(  ็ )를 써서, 표준 모음 기호와 다르게 표기됩니다';
const _shortenedUueNote = '받침이 있어 표준 형태 ◌ือ 대신 ◌ื로 줄어든 형태로 씁니다';
const _lookLongButShortNote = '표기는 장모음(แอ)과 같지만 실제 발음은 짧습니다';
const _clusterNote = '두 개의 자음이 겹치는 자음군(ควบกล้ำ)의 앞 글자입니다';

const List<Word> words = [
  // ── 인사말 (8) ──────────────────────────────────────────────
  Word(
    thai: 'สวัสดี',
    romanization: 'sawatdee',
    meaningKorean: '안녕하세요',
    category: WordCategory.greetings,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ส',
        syllableText: 'ส',
        syllableRoman: 'sa',
        note: '태국어/산스크리트 차용어에서 종종 나타나는 예외로, 모음 기호 없이 짧은 "아" 소리로 읽습니다',
      ),
      WordSyllablePart(
        initialConsonantChar: 'ว',
        vowelDisplayForm: '◌ั',
        finalConsonantChar: 'ส',
        syllableText: 'วัส',
        syllableRoman: 'wat',
      ),
      WordSyllablePart(
        initialConsonantChar: 'ด',
        vowelDisplayForm: '◌ี',
        syllableText: 'ดี',
        syllableRoman: 'dee',
      ),
    ],
  ),
  Word(
    thai: 'ขอบคุณ',
    romanization: 'khopkhun',
    meaningKorean: '감사합니다',
    category: WordCategory.greetings,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ข',
        vowelDisplayForm: '◌อ',
        finalConsonantChar: 'บ',
        syllableText: 'ขอบ',
        syllableRoman: 'khop',
      ),
      WordSyllablePart(
        initialConsonantChar: 'ค',
        vowelDisplayForm: '◌ุ',
        finalConsonantChar: 'ณ',
        syllableText: 'คุณ',
        syllableRoman: 'khun',
      ),
    ],
  ),
  Word(
    thai: 'ขอโทษ',
    romanization: 'khotot',
    meaningKorean: '죄송합니다, 실례합니다',
    category: WordCategory.greetings,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ข',
        vowelDisplayForm: '◌อ',
        syllableText: 'ขอ',
        syllableRoman: 'kho',
      ),
      WordSyllablePart(
        initialConsonantChar: 'ท',
        vowelDisplayForm: 'โ◌',
        finalConsonantChar: 'ษ',
        syllableText: 'โทษ',
        syllableRoman: 'thot',
      ),
    ],
  ),
  Word(
    thai: 'ไม่เป็นไร',
    romanization: 'mai pen rai',
    meaningKorean: '괜찮아요',
    category: WordCategory.greetings,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ม',
        vowelDisplayForm: 'ไ◌',
        syllableText: 'ไม่',
        syllableRoman: 'mai',
      ),
      WordSyllablePart(
        initialConsonantChar: 'ป',
        finalConsonantChar: 'น',
        syllableText: 'เป็น',
        syllableRoman: 'pen',
        note: _shortEBeforeFinalNote,
      ),
      WordSyllablePart(
        initialConsonantChar: 'ร',
        vowelDisplayForm: 'ไ◌',
        syllableText: 'ไร',
        syllableRoman: 'rai',
      ),
    ],
  ),
  Word(
    thai: 'ใช่',
    romanization: 'chai',
    meaningKorean: '네, 맞아요',
    category: WordCategory.greetings,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ช',
        vowelDisplayForm: 'ใ◌',
        syllableText: 'ใช่',
        syllableRoman: 'chai',
      ),
    ],
  ),
  Word(
    thai: 'ไม่ใช่',
    romanization: 'mai chai',
    meaningKorean: '아니요',
    category: WordCategory.greetings,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ม',
        vowelDisplayForm: 'ไ◌',
        syllableText: 'ไม่',
        syllableRoman: 'mai',
      ),
      WordSyllablePart(
        initialConsonantChar: 'ช',
        vowelDisplayForm: 'ใ◌',
        syllableText: 'ใช่',
        syllableRoman: 'chai',
      ),
    ],
  ),
  Word(
    thai: 'ลาก่อน',
    romanization: 'laa kon',
    meaningKorean: '안녕히 가세요 (작별 인사)',
    category: WordCategory.greetings,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ล',
        vowelDisplayForm: '◌า',
        syllableText: 'ลา',
        syllableRoman: 'laa',
      ),
      WordSyllablePart(
        initialConsonantChar: 'ก',
        vowelDisplayForm: '◌อ',
        finalConsonantChar: 'น',
        syllableText: 'ก่อน',
        syllableRoman: 'kon',
      ),
    ],
  ),
  Word(
    thai: 'ยินดี',
    romanization: 'yindee',
    meaningKorean: '반갑습니다, 기쁩니다',
    category: WordCategory.greetings,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ย',
        vowelDisplayForm: '◌ิ',
        finalConsonantChar: 'น',
        syllableText: 'ยิน',
        syllableRoman: 'yin',
      ),
      WordSyllablePart(
        initialConsonantChar: 'ด',
        vowelDisplayForm: '◌ี',
        syllableText: 'ดี',
        syllableRoman: 'dee',
      ),
    ],
  ),
  // ── 숫자 1~10 (10) ──────────────────────────────────────────
  Word(
    thai: 'หนึ่ง',
    romanization: 'neung',
    meaningKorean: '1, 하나',
    category: WordCategory.numbers,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'น',
        vowelDisplayForm: '◌ึ',
        finalConsonantChar: 'ง',
        syllableText: 'หนึ่ง',
        syllableRoman: 'neung',
        note: _leadingHoNote,
        effectiveClassOverride: ConsonantClass.high,
      ),
    ],
  ),
  Word(
    thai: 'สอง',
    romanization: 'song',
    meaningKorean: '2, 둘',
    category: WordCategory.numbers,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ส',
        vowelDisplayForm: '◌อ',
        finalConsonantChar: 'ง',
        syllableText: 'สอง',
        syllableRoman: 'song',
      ),
    ],
  ),
  Word(
    thai: 'สาม',
    romanization: 'saam',
    meaningKorean: '3, 셋',
    category: WordCategory.numbers,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ส',
        vowelDisplayForm: '◌า',
        finalConsonantChar: 'ม',
        syllableText: 'สาม',
        syllableRoman: 'saam',
      ),
    ],
  ),
  Word(
    thai: 'สี่',
    romanization: 'see',
    meaningKorean: '4, 넷',
    category: WordCategory.numbers,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ส',
        vowelDisplayForm: '◌ี',
        syllableText: 'สี่',
        syllableRoman: 'see',
      ),
    ],
  ),
  Word(
    thai: 'ห้า',
    romanization: 'haa',
    meaningKorean: '5, 다섯',
    category: WordCategory.numbers,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ห',
        vowelDisplayForm: '◌า',
        syllableText: 'ห้า',
        syllableRoman: 'haa',
      ),
    ],
  ),
  Word(
    thai: 'หก',
    romanization: 'hok',
    meaningKorean: '6, 여섯',
    category: WordCategory.numbers,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ห',
        finalConsonantChar: 'ก',
        syllableText: 'หก',
        syllableRoman: 'hok',
        note: _inheritedVowelNote,
      ),
    ],
  ),
  Word(
    thai: 'เจ็ด',
    romanization: 'jet',
    meaningKorean: '7, 일곱',
    category: WordCategory.numbers,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'จ',
        finalConsonantChar: 'ด',
        syllableText: 'เจ็ด',
        syllableRoman: 'jet',
        note: _shortEBeforeFinalNote,
      ),
    ],
  ),
  Word(
    thai: 'แปด',
    romanization: 'paet',
    meaningKorean: '8, 여덟',
    category: WordCategory.numbers,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ป',
        vowelDisplayForm: 'แ◌',
        finalConsonantChar: 'ด',
        syllableText: 'แปด',
        syllableRoman: 'paet',
        note: _lookLongButShortNote,
      ),
    ],
  ),
  Word(
    thai: 'เก้า',
    romanization: 'kao',
    meaningKorean: '9, 아홉',
    category: WordCategory.numbers,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ก',
        vowelDisplayForm: 'เ◌า',
        syllableText: 'เก้า',
        syllableRoman: 'kao',
      ),
    ],
  ),
  Word(
    thai: 'สิบ',
    romanization: 'sip',
    meaningKorean: '10, 열',
    category: WordCategory.numbers,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ส',
        vowelDisplayForm: '◌ิ',
        finalConsonantChar: 'บ',
        syllableText: 'สิบ',
        syllableRoman: 'sip',
      ),
    ],
  ),
  // ── 가족 (9) ────────────────────────────────────────────────
  Word(
    thai: 'พ่อ',
    romanization: 'phor',
    meaningKorean: '아빠',
    category: WordCategory.family,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'พ',
        vowelDisplayForm: '◌อ',
        syllableText: 'พ่อ',
        syllableRoman: 'phor',
      ),
    ],
  ),
  Word(
    thai: 'แม่',
    romanization: 'maae',
    meaningKorean: '엄마',
    category: WordCategory.family,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ม',
        vowelDisplayForm: 'แ◌',
        syllableText: 'แม่',
        syllableRoman: 'maae',
      ),
    ],
  ),
  Word(
    thai: 'พี่',
    romanization: 'phee',
    meaningKorean: '형, 오빠, 누나, 언니 (손위 형제)',
    category: WordCategory.family,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'พ',
        vowelDisplayForm: '◌ี',
        syllableText: 'พี่',
        syllableRoman: 'phee',
      ),
    ],
  ),
  Word(
    thai: 'น้อง',
    romanization: 'nong',
    meaningKorean: '동생 (손아래 형제)',
    category: WordCategory.family,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'น',
        vowelDisplayForm: '◌อ',
        finalConsonantChar: 'ง',
        syllableText: 'น้อง',
        syllableRoman: 'nong',
      ),
    ],
  ),
  Word(
    thai: 'ปู่',
    romanization: 'puu',
    meaningKorean: '친할아버지',
    category: WordCategory.family,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ป',
        vowelDisplayForm: '◌ู',
        syllableText: 'ปู่',
        syllableRoman: 'puu',
      ),
    ],
  ),
  Word(
    thai: 'ย่า',
    romanization: 'yaa',
    meaningKorean: '친할머니',
    category: WordCategory.family,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ย',
        vowelDisplayForm: '◌า',
        syllableText: 'ย่า',
        syllableRoman: 'yaa',
      ),
    ],
  ),
  Word(
    thai: 'ตา',
    romanization: 'taa',
    meaningKorean: '외할아버지',
    category: WordCategory.family,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ต',
        vowelDisplayForm: '◌า',
        syllableText: 'ตา',
        syllableRoman: 'taa',
      ),
    ],
  ),
  Word(
    thai: 'ยาย',
    romanization: 'yaai',
    meaningKorean: '외할머니',
    category: WordCategory.family,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ย',
        vowelDisplayForm: '◌า',
        finalConsonantChar: 'ย',
        syllableText: 'ยาย',
        syllableRoman: 'yaai',
      ),
    ],
  ),
  Word(
    thai: 'ลูก',
    romanization: 'luuk',
    meaningKorean: '자식, 아이',
    category: WordCategory.family,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ล',
        vowelDisplayForm: '◌ู',
        finalConsonantChar: 'ก',
        syllableText: 'ลูก',
        syllableRoman: 'luuk',
      ),
    ],
  ),
  // ── 음식 (9) ────────────────────────────────────────────────
  Word(
    thai: 'ข้าว',
    romanization: 'khao',
    meaningKorean: '밥, 쌀',
    category: WordCategory.food,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ข',
        vowelDisplayForm: '◌า',
        finalConsonantChar: 'ว',
        syllableText: 'ข้าว',
        syllableRoman: 'khao',
      ),
    ],
  ),
  Word(
    thai: 'น้ำ',
    romanization: 'naam',
    meaningKorean: '물',
    category: WordCategory.food,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'น',
        vowelDisplayForm: '◌ำ',
        syllableText: 'น้ำ',
        syllableRoman: 'naam',
      ),
    ],
  ),
  Word(
    thai: 'ไข่',
    romanization: 'khai',
    meaningKorean: '달걀',
    category: WordCategory.food,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ข',
        vowelDisplayForm: 'ไ◌',
        syllableText: 'ไข่',
        syllableRoman: 'khai',
      ),
    ],
  ),
  Word(
    thai: 'หมู',
    romanization: 'muu',
    meaningKorean: '돼지고기',
    category: WordCategory.food,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ม',
        vowelDisplayForm: '◌ู',
        syllableText: 'หมู',
        syllableRoman: 'muu',
        note: _leadingHoNote,
        effectiveClassOverride: ConsonantClass.high,
      ),
    ],
  ),
  Word(
    thai: 'ไก่',
    romanization: 'kai',
    meaningKorean: '닭고기',
    category: WordCategory.food,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ก',
        vowelDisplayForm: 'ไ◌',
        syllableText: 'ไก่',
        syllableRoman: 'kai',
      ),
    ],
  ),
  Word(
    thai: 'กุ้ง',
    romanization: 'kung',
    meaningKorean: '새우',
    category: WordCategory.food,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ก',
        vowelDisplayForm: '◌ุ',
        finalConsonantChar: 'ง',
        syllableText: 'กุ้ง',
        syllableRoman: 'kung',
      ),
    ],
  ),
  Word(
    thai: 'ผัก',
    romanization: 'phak',
    meaningKorean: '채소',
    category: WordCategory.food,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ผ',
        vowelDisplayForm: '◌ั',
        finalConsonantChar: 'ก',
        syllableText: 'ผัก',
        syllableRoman: 'phak',
      ),
    ],
  ),
  Word(
    thai: 'ชา',
    romanization: 'chaa',
    meaningKorean: '차 (마시는 차)',
    category: WordCategory.food,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ช',
        vowelDisplayForm: '◌า',
        syllableText: 'ชา',
        syllableRoman: 'chaa',
      ),
    ],
  ),
  Word(
    thai: 'กาแฟ',
    romanization: 'kaafae',
    meaningKorean: '커피',
    category: WordCategory.food,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ก',
        vowelDisplayForm: '◌า',
        syllableText: 'กา',
        syllableRoman: 'kaa',
      ),
      WordSyllablePart(
        initialConsonantChar: 'ฟ',
        vowelDisplayForm: 'แ◌',
        syllableText: 'แฟ',
        syllableRoman: 'fae',
      ),
    ],
  ),
  // ── 동물 (9) ────────────────────────────────────────────────
  Word(
    thai: 'ช้าง',
    romanization: 'chaang',
    meaningKorean: '코끼리',
    category: WordCategory.animals,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ช',
        vowelDisplayForm: '◌า',
        finalConsonantChar: 'ง',
        syllableText: 'ช้าง',
        syllableRoman: 'chaang',
      ),
    ],
  ),
  Word(
    thai: 'เสือ',
    romanization: 'suea',
    meaningKorean: '호랑이',
    category: WordCategory.animals,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ส',
        vowelDisplayForm: 'เ◌ือ',
        syllableText: 'เสือ',
        syllableRoman: 'suea',
      ),
    ],
  ),
  Word(
    thai: 'งู',
    romanization: 'nguu',
    meaningKorean: '뱀',
    category: WordCategory.animals,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ง',
        vowelDisplayForm: '◌ู',
        syllableText: 'งู',
        syllableRoman: 'nguu',
      ),
    ],
  ),
  Word(
    thai: 'ลิง',
    romanization: 'ling',
    meaningKorean: '원숭이',
    category: WordCategory.animals,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ล',
        vowelDisplayForm: '◌ิ',
        finalConsonantChar: 'ง',
        syllableText: 'ลิง',
        syllableRoman: 'ling',
      ),
    ],
  ),
  Word(
    thai: 'ม้า',
    romanization: 'maa',
    meaningKorean: '말 (동물)',
    category: WordCategory.animals,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ม',
        vowelDisplayForm: '◌า',
        syllableText: 'ม้า',
        syllableRoman: 'maa',
      ),
    ],
  ),
  Word(
    thai: 'แมว',
    romanization: 'maeo',
    meaningKorean: '고양이',
    category: WordCategory.animals,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ม',
        vowelDisplayForm: 'แ◌',
        finalConsonantChar: 'ว',
        syllableText: 'แมว',
        syllableRoman: 'maeo',
      ),
    ],
  ),
  Word(
    thai: 'หมา',
    romanization: 'maa',
    meaningKorean: '개',
    category: WordCategory.animals,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ม',
        vowelDisplayForm: '◌า',
        syllableText: 'หมา',
        syllableRoman: 'maa',
        note: _leadingHoNote,
        effectiveClassOverride: ConsonantClass.high,
      ),
    ],
  ),
  Word(
    thai: 'นก',
    romanization: 'nok',
    meaningKorean: '새',
    category: WordCategory.animals,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'น',
        finalConsonantChar: 'ก',
        syllableText: 'นก',
        syllableRoman: 'nok',
        note: _inheritedVowelNote,
      ),
    ],
  ),
  Word(
    thai: 'เต่า',
    romanization: 'tao',
    meaningKorean: '거북이',
    category: WordCategory.animals,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ต',
        vowelDisplayForm: 'เ◌า',
        syllableText: 'เต่า',
        syllableRoman: 'tao',
      ),
    ],
  ),
  // ── 색깔 (8) ────────────────────────────────────────────────
  Word(
    thai: 'สีแดง',
    romanization: 'see daeng',
    meaningKorean: '빨간색',
    category: WordCategory.colors,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ส',
        vowelDisplayForm: '◌ี',
        syllableText: 'สี',
        syllableRoman: 'see',
      ),
      WordSyllablePart(
        initialConsonantChar: 'ด',
        vowelDisplayForm: 'แ◌',
        finalConsonantChar: 'ง',
        syllableText: 'แดง',
        syllableRoman: 'daeng',
      ),
    ],
  ),
  Word(
    thai: 'สีเขียว',
    romanization: 'see khiao',
    meaningKorean: '초록색',
    category: WordCategory.colors,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ส',
        vowelDisplayForm: '◌ี',
        syllableText: 'สี',
        syllableRoman: 'see',
      ),
      WordSyllablePart(
        initialConsonantChar: 'ข',
        vowelDisplayForm: 'เ◌ีย',
        finalConsonantChar: 'ว',
        syllableText: 'เขียว',
        syllableRoman: 'khiao',
      ),
    ],
  ),
  Word(
    thai: 'สีเหลือง',
    romanization: 'see lueang',
    meaningKorean: '노란색',
    category: WordCategory.colors,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ส',
        vowelDisplayForm: '◌ี',
        syllableText: 'สี',
        syllableRoman: 'see',
      ),
      WordSyllablePart(
        initialConsonantChar: 'ล',
        vowelDisplayForm: 'เ◌ือ',
        finalConsonantChar: 'ง',
        syllableText: 'เหลือง',
        syllableRoman: 'lueang',
        note: _leadingHoNote,
        effectiveClassOverride: ConsonantClass.high,
      ),
    ],
  ),
  Word(
    thai: 'สีฟ้า',
    romanization: 'see faa',
    meaningKorean: '파란색, 하늘색',
    category: WordCategory.colors,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ส',
        vowelDisplayForm: '◌ี',
        syllableText: 'สี',
        syllableRoman: 'see',
      ),
      WordSyllablePart(
        initialConsonantChar: 'ฟ',
        vowelDisplayForm: '◌า',
        syllableText: 'ฟ้า',
        syllableRoman: 'faa',
      ),
    ],
  ),
  Word(
    thai: 'สีดำ',
    romanization: 'see dam',
    meaningKorean: '검은색',
    category: WordCategory.colors,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ส',
        vowelDisplayForm: '◌ี',
        syllableText: 'สี',
        syllableRoman: 'see',
      ),
      WordSyllablePart(
        initialConsonantChar: 'ด',
        vowelDisplayForm: '◌ำ',
        syllableText: 'ดำ',
        syllableRoman: 'dam',
      ),
    ],
  ),
  Word(
    thai: 'สีขาว',
    romanization: 'see khao',
    meaningKorean: '흰색',
    category: WordCategory.colors,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ส',
        vowelDisplayForm: '◌ี',
        syllableText: 'สี',
        syllableRoman: 'see',
      ),
      WordSyllablePart(
        initialConsonantChar: 'ข',
        vowelDisplayForm: '◌า',
        finalConsonantChar: 'ว',
        syllableText: 'ขาว',
        syllableRoman: 'khao',
      ),
    ],
  ),
  Word(
    thai: 'สีชมพู',
    romanization: 'see chomphuu',
    meaningKorean: '분홍색',
    category: WordCategory.colors,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ส',
        vowelDisplayForm: '◌ี',
        syllableText: 'สี',
        syllableRoman: 'see',
      ),
      WordSyllablePart(
        initialConsonantChar: 'ช',
        finalConsonantChar: 'ม',
        syllableText: 'ชม',
        syllableRoman: 'chom',
        note: _inheritedVowelNote,
      ),
      WordSyllablePart(
        initialConsonantChar: 'พ',
        vowelDisplayForm: '◌ู',
        syllableText: 'พู',
        syllableRoman: 'phuu',
      ),
    ],
  ),
  Word(
    thai: 'สีส้ม',
    romanization: 'see som',
    meaningKorean: '주황색',
    category: WordCategory.colors,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ส',
        vowelDisplayForm: '◌ี',
        syllableText: 'สี',
        syllableRoman: 'see',
      ),
      WordSyllablePart(
        initialConsonantChar: 'ส',
        finalConsonantChar: 'ม',
        syllableText: 'ส้ม',
        syllableRoman: 'som',
        note: _inheritedVowelNote,
      ),
    ],
  ),
  // ── 시간·요일 (8) ───────────────────────────────────────────
  Word(
    thai: 'วันนี้',
    romanization: 'wan nee',
    meaningKorean: '오늘',
    category: WordCategory.time,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ว',
        vowelDisplayForm: '◌ั',
        finalConsonantChar: 'น',
        syllableText: 'วัน',
        syllableRoman: 'wan',
      ),
      WordSyllablePart(
        initialConsonantChar: 'น',
        vowelDisplayForm: '◌ี',
        syllableText: 'นี้',
        syllableRoman: 'nee',
      ),
    ],
  ),
  Word(
    thai: 'พรุ่งนี้',
    romanization: 'phrungnee',
    meaningKorean: '내일',
    category: WordCategory.time,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'พ',
        vowelDisplayForm: '◌ุ',
        finalConsonantChar: 'ง',
        syllableText: 'พรุ่ง',
        syllableRoman: 'phrung',
        note: _clusterNote,
      ),
      WordSyllablePart(
        initialConsonantChar: 'น',
        vowelDisplayForm: '◌ี',
        syllableText: 'นี้',
        syllableRoman: 'nee',
      ),
    ],
  ),
  Word(
    thai: 'เมื่อวาน',
    romanization: 'mueawaan',
    meaningKorean: '어제',
    category: WordCategory.time,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ม',
        vowelDisplayForm: 'เ◌ือ',
        syllableText: 'เมื่อ',
        syllableRoman: 'muea',
      ),
      WordSyllablePart(
        initialConsonantChar: 'ว',
        vowelDisplayForm: '◌า',
        finalConsonantChar: 'น',
        syllableText: 'วาน',
        syllableRoman: 'waan',
      ),
    ],
  ),
  Word(
    thai: 'เช้า',
    romanization: 'chao',
    meaningKorean: '아침',
    category: WordCategory.time,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ช',
        vowelDisplayForm: 'เ◌า',
        syllableText: 'เช้า',
        syllableRoman: 'chao',
      ),
    ],
  ),
  Word(
    thai: 'เย็น',
    romanization: 'yen',
    meaningKorean: '저녁, (날씨가) 시원한',
    category: WordCategory.time,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ย',
        finalConsonantChar: 'น',
        syllableText: 'เย็น',
        syllableRoman: 'yen',
        note: _shortEBeforeFinalNote,
      ),
    ],
  ),
  Word(
    thai: 'คืน',
    romanization: 'khuen',
    meaningKorean: '밤',
    category: WordCategory.time,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ค',
        vowelDisplayForm: '◌ือ',
        finalConsonantChar: 'น',
        syllableText: 'คืน',
        syllableRoman: 'khuen',
        note: _shortenedUueNote,
      ),
    ],
  ),
  Word(
    thai: 'ตอนนี้',
    romanization: 'tonnee',
    meaningKorean: '지금',
    category: WordCategory.time,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ต',
        vowelDisplayForm: '◌อ',
        finalConsonantChar: 'น',
        syllableText: 'ตอน',
        syllableRoman: 'ton',
      ),
      WordSyllablePart(
        initialConsonantChar: 'น',
        vowelDisplayForm: '◌ี',
        syllableText: 'นี้',
        syllableRoman: 'nee',
      ),
    ],
  ),
  Word(
    thai: 'เวลา',
    romanization: 'welaa',
    meaningKorean: '시간',
    category: WordCategory.time,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ว',
        vowelDisplayForm: 'เ◌',
        syllableText: 'เว',
        syllableRoman: 'we',
      ),
      WordSyllablePart(
        initialConsonantChar: 'ล',
        vowelDisplayForm: '◌า',
        syllableText: 'ลา',
        syllableRoman: 'laa',
      ),
    ],
  ),
  // ── 일상 사물 (8) ───────────────────────────────────────────
  Word(
    thai: 'บ้าน',
    romanization: 'baan',
    meaningKorean: '집',
    category: WordCategory.objects,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'บ',
        vowelDisplayForm: '◌า',
        finalConsonantChar: 'น',
        syllableText: 'บ้าน',
        syllableRoman: 'baan',
      ),
    ],
  ),
  Word(
    thai: 'รถ',
    romanization: 'rot',
    meaningKorean: '자동차',
    category: WordCategory.objects,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ร',
        finalConsonantChar: 'ถ',
        syllableText: 'รถ',
        syllableRoman: 'rot',
        note: _inheritedVowelNote,
      ),
    ],
  ),
  Word(
    thai: 'หนังสือ',
    romanization: 'nangsue',
    meaningKorean: '책',
    category: WordCategory.objects,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'น',
        vowelDisplayForm: '◌ั',
        finalConsonantChar: 'ง',
        syllableText: 'หนัง',
        syllableRoman: 'nang',
        note: _leadingHoNote,
        effectiveClassOverride: ConsonantClass.high,
      ),
      WordSyllablePart(
        initialConsonantChar: 'ส',
        vowelDisplayForm: '◌ือ',
        syllableText: 'สือ',
        syllableRoman: 'sue',
      ),
    ],
  ),
  Word(
    thai: 'โต๊ะ',
    romanization: 'to',
    meaningKorean: '책상, 탁자',
    category: WordCategory.objects,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ต',
        vowelDisplayForm: 'โ◌ะ',
        syllableText: 'โต๊ะ',
        syllableRoman: 'to',
      ),
    ],
  ),
  Word(
    thai: 'เก้าอี้',
    romanization: 'kaoee',
    meaningKorean: '의자',
    category: WordCategory.objects,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ก',
        vowelDisplayForm: 'เ◌า',
        syllableText: 'เก้า',
        syllableRoman: 'kao',
      ),
      WordSyllablePart(
        initialConsonantChar: 'อ',
        vowelDisplayForm: '◌ี',
        syllableText: 'อี้',
        syllableRoman: 'ee',
      ),
    ],
  ),
  Word(
    thai: 'หน้าต่าง',
    romanization: 'naa taang',
    meaningKorean: '창문',
    category: WordCategory.objects,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'น',
        vowelDisplayForm: '◌า',
        syllableText: 'หน้า',
        syllableRoman: 'naa',
        note: _leadingHoNote,
        effectiveClassOverride: ConsonantClass.high,
      ),
      WordSyllablePart(
        initialConsonantChar: 'ต',
        vowelDisplayForm: '◌า',
        finalConsonantChar: 'ง',
        syllableText: 'ต่าง',
        syllableRoman: 'taang',
      ),
    ],
  ),
  Word(
    thai: 'ถุง',
    romanization: 'thung',
    meaningKorean: '가방, 봉지',
    category: WordCategory.objects,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ถ',
        vowelDisplayForm: '◌ุ',
        finalConsonantChar: 'ง',
        syllableText: 'ถุง',
        syllableRoman: 'thung',
      ),
    ],
  ),
  Word(
    thai: 'รองเท้า',
    romanization: 'rongthao',
    meaningKorean: '신발',
    category: WordCategory.objects,
    syllables: [
      WordSyllablePart(
        initialConsonantChar: 'ร',
        vowelDisplayForm: '◌อ',
        finalConsonantChar: 'ง',
        syllableText: 'รอง',
        syllableRoman: 'rong',
      ),
      WordSyllablePart(
        initialConsonantChar: 'ท',
        vowelDisplayForm: 'เ◌า',
        syllableText: 'เท้า',
        syllableRoman: 'thao',
      ),
    ],
  ),
];
