import 'package:flutter_tts/flutter_tts.dart';

/// 기기에 설치된 태국어 TTS 음성으로 글자/단어를 읽어주는 서비스.
class TtsService {
  TtsService() {
    _initFuture = _init();
  }

  final FlutterTts _flutterTts = FlutterTts();
  late final Future<void> _initFuture;
  bool _isReady = false;

  Future<void> _init() async {
    await _flutterTts.setLanguage('th-TH');
    await _flutterTts.setSpeechRate(0.4);
    _isReady = true;
  }

  /// iOS Safari 등 일부 브라우저는 사용자의 탭 이벤트와 완전히 같은 동기 흐름
  /// 안에서 speak()가 호출되어야만 소리를 허용한다(그 사이에 await가 하나라도
  /// 끼면 "사용자 동작 없이 호출됨"으로 간주해 조용히 무시함). 초기화가 이미
  /// 끝난 뒤에는 await 없이 바로 호출해서 이 제약을 지킨다.
  void speak(String text) {
    if (_isReady) {
      _flutterTts.stop();
      _flutterTts.speak(text);
    } else {
      _initFuture.then((_) {
        _flutterTts.stop();
        _flutterTts.speak(text);
      });
    }
  }

  Future<void> dispose() async {
    await _flutterTts.stop();
  }
}
