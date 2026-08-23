import 'package:flutter_tts/flutter_tts.dart';

/// 네이티브(데스크톱 등) 전용 구현: flutter_tts 플러그인을 그대로 사용한다.
class TtsPlatform {
  TtsPlatform() {
    _initFuture = _init();
  }

  final FlutterTts _flutterTts = FlutterTts();
  late final Future<void> _initFuture;
  bool _isReady = false;

  final List<String> log = ['(네이티브 환경에서는 진단 로그를 지원하지 않습니다)'];
  void Function()? onLogUpdate;

  bool get isSupported => true;
  List<String> get voiceSummaries => ['(네이티브 환경에서는 음성 목록 조회를 지원하지 않습니다)'];

  Future<void> _init() async {
    await _flutterTts.setLanguage('th-TH');
    await _flutterTts.setSpeechRate(0.4);
    _isReady = true;
  }

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
