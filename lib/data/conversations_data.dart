import '../models/conversation.dart';

/// A는 편의상 남성 화자(ครับ), B는 여성 화자(ค่ะ/คะ)로 통일했다 — 다만 쇼핑·길 묻기
/// 대화에서는 실제 상황에 맞춰 역할의 성별을 바꿔서 두 어미를 골고루 보여준다.
const List<Dialogue> dialogues = [
  Dialogue(
    title: '인사 나누기',
    category: ConversationCategory.greetings,
    lines: [
      DialogueLine(
        speaker: Speaker.a,
        thai: 'สวัสดีครับ',
        romanization: 'sawatdee khrap',
        meaningKorean: '안녕하세요',
        relatedWords: ['สวัสดี'],
      ),
      DialogueLine(
        speaker: Speaker.b,
        thai: 'สวัสดีค่ะ',
        romanization: 'sawatdee kha',
        meaningKorean: '안녕하세요',
        relatedWords: ['สวัสดี'],
      ),
      DialogueLine(
        speaker: Speaker.a,
        thai: 'สบายดีไหมครับ',
        romanization: 'sabaai dee mai khrap',
        meaningKorean: '잘 지내세요?',
      ),
      DialogueLine(
        speaker: Speaker.b,
        thai: 'สบายดีค่ะ ขอบคุณค่ะ',
        romanization: 'sabaai dee kha, khopkhun kha',
        meaningKorean: '잘 지내요, 감사합니다',
        relatedWords: ['ขอบคุณ'],
      ),
      DialogueLine(
        speaker: Speaker.a,
        thai: 'ไม่เป็นไรครับ',
        romanization: 'mai pen rai khrap',
        meaningKorean: '천만에요',
        relatedWords: ['ไม่เป็นไร'],
      ),
    ],
  ),
  Dialogue(
    title: '자기소개',
    category: ConversationCategory.selfIntro,
    lines: [
      DialogueLine(
        speaker: Speaker.a,
        thai: 'คุณชื่ออะไรครับ',
        romanization: 'khun chue arai khrap',
        meaningKorean: '이름이 뭐예요?',
      ),
      DialogueLine(
        speaker: Speaker.b,
        thai: 'ดิฉันชื่อมีนาค่ะ',
        romanization: 'dichan chue Mina kha',
        meaningKorean: '저는 미나예요',
      ),
      DialogueLine(
        speaker: Speaker.a,
        thai: 'ยินดีที่ได้รู้จักครับ',
        romanization: 'yindee thii dai ruujak khrap',
        meaningKorean: '만나서 반갑습니다',
        relatedWords: ['ยินดี'],
      ),
      DialogueLine(
        speaker: Speaker.b,
        thai: 'ยินดีที่ได้รู้จักเช่นกันค่ะ',
        romanization: 'yindee thii dai ruujak chenkan kha',
        meaningKorean: '저도 반갑습니다',
        relatedWords: ['ยินดี'],
      ),
      DialogueLine(
        speaker: Speaker.a,
        thai: 'คุณมาจากประเทศอะไรครับ',
        romanization: 'khun maajaak prathet arai khrap',
        meaningKorean: '어느 나라에서 왔어요?',
      ),
      DialogueLine(
        speaker: Speaker.b,
        thai: 'ดิฉันมาจากเกาหลีค่ะ',
        romanization: 'dichan maajaak kaoli kha',
        meaningKorean: '저는 한국에서 왔어요',
      ),
    ],
  ),
  Dialogue(
    title: '가족 소개',
    category: ConversationCategory.family,
    lines: [
      DialogueLine(
        speaker: Speaker.a,
        thai: 'นี่ใครครับ',
        romanization: 'nii khrai khrap',
        meaningKorean: '이 분은 누구예요?',
      ),
      DialogueLine(
        speaker: Speaker.b,
        thai: 'นี่พ่อของดิฉันค่ะ',
        romanization: 'nii phor khong dichan kha',
        meaningKorean: '이 분은 제 아빠예요',
        relatedWords: ['พ่อ'],
      ),
      DialogueLine(
        speaker: Speaker.a,
        thai: 'แล้วนี่ล่ะครับ',
        romanization: 'laeo nii la khrap',
        meaningKorean: '그럼 이 분은요?',
      ),
      DialogueLine(
        speaker: Speaker.b,
        thai: 'นี่แม่ค่ะ',
        romanization: 'nii maae kha',
        meaningKorean: '이 분은 엄마예요',
        relatedWords: ['แม่'],
      ),
      DialogueLine(
        speaker: Speaker.a,
        thai: 'มีพี่น้องไหมครับ',
        romanization: 'mii phii nong mai khrap',
        meaningKorean: '형제자매 있어요?',
        relatedWords: ['พี่', 'น้อง'],
      ),
      DialogueLine(
        speaker: Speaker.b,
        thai: 'มีค่ะ มีน้องสาวหนึ่งคน',
        romanization: 'mii kha, mii nongsaao neung khon',
        meaningKorean: '있어요, 여동생이 한 명 있어요',
        relatedWords: ['น้อง', 'หนึ่ง'],
      ),
    ],
  ),
  Dialogue(
    title: '식당에서',
    category: ConversationCategory.restaurant,
    lines: [
      DialogueLine(
        speaker: Speaker.a,
        thai: 'ขอเมนูหน่อยครับ',
        romanization: 'kho menuu noi khrap',
        meaningKorean: '메뉴 좀 주세요',
      ),
      DialogueLine(
        speaker: Speaker.b,
        thai: 'ได้ค่ะ เชิญค่ะ',
        romanization: 'dai kha, choen kha',
        meaningKorean: '네, 여기 있어요',
      ),
      DialogueLine(
        speaker: Speaker.a,
        thai: 'ขอข้าวผัดหนึ่งจานครับ',
        romanization: 'kho khaaophat neung jaan khrap',
        meaningKorean: '볶음밥 한 접시 주세요',
        relatedWords: ['ข้าว', 'หนึ่ง'],
      ),
      DialogueLine(
        speaker: Speaker.b,
        thai: 'ได้ค่ะ รอสักครู่นะคะ',
        romanization: 'dai kha, ro sak khruu na kha',
        meaningKorean: '네, 잠시만 기다려주세요',
      ),
      DialogueLine(
        speaker: Speaker.a,
        thai: 'เท่าไหร่ครับ',
        romanization: 'thaorai khrap',
        meaningKorean: '얼마예요?',
      ),
      DialogueLine(
        speaker: Speaker.b,
        thai: 'ห้าสิบบาทค่ะ',
        romanization: 'haasip baht kha',
        meaningKorean: '50바트예요',
        relatedWords: ['ห้า', 'สิบ'],
      ),
    ],
  ),
  Dialogue(
    title: '쇼핑',
    category: ConversationCategory.shopping,
    lines: [
      DialogueLine(
        speaker: Speaker.a,
        thai: 'อันนี้ราคาเท่าไหร่คะ',
        romanization: 'an nii raakhaa thaorai kha',
        meaningKorean: '이거 얼마예요?',
      ),
      DialogueLine(
        speaker: Speaker.b,
        thai: 'สามร้อยบาทครับ',
        romanization: 'saam roi baht khrap',
        meaningKorean: '300바트입니다',
        relatedWords: ['สาม'],
      ),
      DialogueLine(
        speaker: Speaker.a,
        thai: 'ลดราคาได้ไหมคะ',
        romanization: 'lot raakhaa dai mai kha',
        meaningKorean: '깎아줄 수 있어요?',
      ),
      DialogueLine(
        speaker: Speaker.b,
        thai: 'ลดให้ยี่สิบบาทครับ',
        romanization: 'lot hai yiisip baht khrap',
        meaningKorean: '20바트 깎아드릴게요',
      ),
      DialogueLine(
        speaker: Speaker.a,
        thai: 'ขอบคุณค่ะ',
        romanization: 'khopkhun kha',
        meaningKorean: '감사합니다',
        relatedWords: ['ขอบคุณ'],
      ),
    ],
  ),
  Dialogue(
    title: '길 묻기·택시',
    category: ConversationCategory.directions,
    lines: [
      DialogueLine(
        speaker: Speaker.a,
        thai: 'ห้องน้ำอยู่ที่ไหนครับ',
        romanization: 'hongnaam yuu thii nai khrap',
        meaningKorean: '화장실이 어디예요?',
      ),
      DialogueLine(
        speaker: Speaker.b,
        thai: 'อยู่ทางนั้นค่ะ',
        romanization: 'yuu thaang nan kha',
        meaningKorean: '저쪽에 있어요',
      ),
      DialogueLine(
        speaker: Speaker.a,
        thai: 'ขอบคุณครับ',
        romanization: 'khopkhun khrap',
        meaningKorean: '감사합니다',
        relatedWords: ['ขอบคุณ'],
      ),
      DialogueLine(
        speaker: Speaker.a,
        thai: 'ไปสนามบินเท่าไหร่ครับ',
        romanization: 'pai sanaambin thaorai khrap',
        meaningKorean: '공항까지 얼마예요?',
      ),
      DialogueLine(
        speaker: Speaker.b,
        thai: 'สามร้อยบาทค่ะ',
        romanization: 'saam roi baht kha',
        meaningKorean: '300바트예요',
        relatedWords: ['สาม'],
      ),
      DialogueLine(
        speaker: Speaker.a,
        thai: 'ไปเลยครับ',
        romanization: 'pai loei khrap',
        meaningKorean: '가주세요',
      ),
    ],
  ),
  Dialogue(
    title: '작별 인사',
    category: ConversationCategory.farewell,
    lines: [
      DialogueLine(
        speaker: Speaker.a,
        thai: 'ผมต้องไปแล้วครับ',
        romanization: 'phom tong pai laeo khrap',
        meaningKorean: '저는 이제 가야 해요',
      ),
      DialogueLine(
        speaker: Speaker.b,
        thai: 'แล้วเจอกันใหม่นะคะ',
        romanization: 'laeo joe kan mai na kha',
        meaningKorean: '또 만나요',
      ),
      DialogueLine(
        speaker: Speaker.a,
        thai: 'ลาก่อนครับ',
        romanization: 'laakon khrap',
        meaningKorean: '안녕히 계세요',
        relatedWords: ['ลาก่อน'],
      ),
      DialogueLine(
        speaker: Speaker.b,
        thai: 'ลาก่อนค่ะ',
        romanization: 'laakon kha',
        meaningKorean: '안녕히 가세요',
        relatedWords: ['ลาก่อน'],
      ),
    ],
  ),
];
