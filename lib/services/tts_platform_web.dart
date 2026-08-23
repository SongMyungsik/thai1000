import 'dart:js_interop';

@JS('speechSynthesis')
external _SpeechSynthesis get _synth;

@JS()
extension type _SpeechSynthesis._(JSObject _) implements JSObject {
  external void cancel();
  external JSArray<_SpeechSynthesisVoice> getVoices();
  external void speak(_SpeechSynthesisUtterance utterance);
}

@JS()
extension type _SpeechSynthesisUtterance._(JSObject _) implements JSObject {
  external _SpeechSynthesisUtterance();
  external String text;
  external String lang;
  external double rate;
  external _SpeechSynthesisVoice? voice;
}

@JS()
extension type _SpeechSynthesisVoice._(JSObject _) implements JSObject {
  external String get lang;
}

/// 웹 전용 구현: 브라우저의 Web Speech API(`speechSynthesis`)를 flutter_tts를
/// 거치지 않고 직접 호출한다. iOS Safari는 사용자의 탭 이벤트와 완전히 같은
/// 동기 실행 흐름 안에서 speak()가 호출되어야만 소리를 허용하는데, 플러그인의
/// MethodChannel을 거치면 그 사이에 비동기 경계가 끼어들 수 있어 이 제약을
/// 못 지킬 위험이 있다. 음성 목록도 매번 새로 조회해서, 페이지 로드 직후라
/// 아직 목록이 안 채워졌더라도 다음 재생 때는 자동으로 태국어 음성을 찾는다.
class TtsPlatform {
  void speak(String text) {
    _synth.cancel();
    final utterance = _SpeechSynthesisUtterance()
      ..text = text
      ..rate = 0.4
      ..lang = 'th-TH';

    for (final voice in _synth.getVoices().toDart) {
      if (voice.lang.toLowerCase().startsWith('th')) {
        utterance.voice = voice;
        utterance.lang = voice.lang;
        break;
      }
    }

    _synth.speak(utterance);
  }

  Future<void> dispose() async {
    _synth.cancel();
  }
}
