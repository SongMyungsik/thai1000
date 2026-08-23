import 'dart:js_interop';

@JS('speechSynthesis')
external _SpeechSynthesis get _synth;

@JS('SpeechSynthesis')
extension type _SpeechSynthesis._(JSObject _) implements JSObject {
  external void cancel();
  external JSArray<_SpeechSynthesisVoice> getVoices();
  external void speak(_SpeechSynthesisUtterance utterance);
}

@JS('SpeechSynthesisUtterance')
extension type _SpeechSynthesisUtterance._(JSObject _) implements JSObject {
  external _SpeechSynthesisUtterance();
  external String text;
  external String lang;
  external double rate;
  external _SpeechSynthesisVoice? voice;

  @JS('onstart')
  external set onStart(JSFunction listener);

  @JS('onend')
  external set onEnd(JSFunction listener);

  @JS('onerror')
  external set onError(JSFunction listener);
}

@JS('SpeechSynthesisVoice')
extension type _SpeechSynthesisVoice._(JSObject _) implements JSObject {
  external String get lang;
  external String get name;
}

@JS('SpeechSynthesisErrorEvent')
extension type _SpeechSynthesisErrorEvent._(JSObject _) implements JSObject {
  external String get error;
}

/// 웹 전용 구현: 브라우저의 Web Speech API(`speechSynthesis`)를 flutter_tts를
/// 거치지 않고 직접 호출한다. iOS Safari는 사용자의 탭 이벤트와 완전히 같은
/// 동기 실행 흐름 안에서 speak()가 호출되어야만 소리를 허용하는데, 플러그인의
/// MethodChannel을 거치면 그 사이에 비동기 경계가 끼어들 수 있어 이 제약을
/// 못 지킬 위험이 있다. 음성 목록도 매번 새로 조회해서, 페이지 로드 직후라
/// 아직 목록이 안 채워졌더라도 다음 재생 때는 자동으로 태국어 음성을 찾는다.
///
/// [_currentUtterance]는 Safari의 알려진 버그(발음 객체를 지역 변수로만 두면
/// 재생 도중 가비지 컬렉션되어 소리가 끊기는 문제)를 피하려고 인스턴스 필드로
/// 계속 참조를 붙잡아 둔다.
///
/// [log]/[onLogUpdate]는 화면 진단(TTS 문제 진단 화면)에서 실제로 무슨 일이
/// 일어나는지 보여주기 위한 것이다.
class TtsPlatform {
  _SpeechSynthesisUtterance? _currentUtterance;

  final List<String> log = [];
  void Function()? onLogUpdate;

  void _log(String message) {
    log.add(message);
    if (log.length > 40) log.removeAt(0);
    onLogUpdate?.call();
  }

  bool get isSupported {
    try {
      // ignore: unnecessary_statements
      _synth;
      return true;
    } catch (_) {
      return false;
    }
  }

  List<String> get voiceSummaries {
    try {
      return _synth
          .getVoices()
          .toDart
          .map((v) => '${v.name} (${v.lang})')
          .toList();
    } catch (e) {
      return ['음성 목록 조회 실패: $e'];
    }
  }

  void speak(String text) {
    try {
      _synth.cancel();
      final utterance = _SpeechSynthesisUtterance()
        ..text = text
        ..rate = 0.4
        ..lang = 'th-TH';

      _SpeechSynthesisVoice? matched;
      for (final voice in _synth.getVoices().toDart) {
        if (voice.lang.toLowerCase().startsWith('th')) {
          matched = voice;
          break;
        }
      }
      if (matched != null) {
        utterance.voice = matched;
        utterance.lang = matched.lang;
        _log('음성 찾음: ${matched.name} (${matched.lang})');
      } else {
        _log('태국어 음성을 못 찾음 → 기본 음성으로 시도');
      }

      void clearIfCurrent() {
        if (identical(_currentUtterance, utterance)) {
          _currentUtterance = null;
        }
      }

      utterance.onStart = ((JSAny? _) {
        _log('▶ onstart 이벤트 발생 (재생 시작됨)');
      }).toJS;
      utterance.onEnd = ((JSAny? _) {
        _log('■ onend 이벤트 발생 (재생 종료됨)');
        clearIfCurrent();
      }).toJS;
      utterance.onError = ((_SpeechSynthesisErrorEvent event) {
        _log('✕ onerror 이벤트 발생: ${event.error}');
        clearIfCurrent();
      }).toJS;

      _currentUtterance = utterance;
      _log('speak("$text") 호출');
      _synth.speak(utterance);
      _log('speak() 호출 완료 (예외 없이 반환됨)');
    } catch (e) {
      _log('speak() 호출 중 예외 발생: $e');
    }
  }

  Future<void> dispose() async {
    _synth.cancel();
    _currentUtterance = null;
  }
}
