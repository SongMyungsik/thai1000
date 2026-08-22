import 'package:flutter_tts/flutter_tts.dart';

/// 기기에 설치된 태국어 TTS 음성으로 글자/단어를 읽어주는 서비스.
class TtsService {
  TtsService() {
    _ready = _init();
  }

  final FlutterTts _flutterTts = FlutterTts();
  late final Future<void> _ready;

  Future<void> _init() async {
    await _flutterTts.setLanguage('th-TH');
    await _flutterTts.setSpeechRate(0.4);
  }

  Future<void> speak(String text) async {
    await _ready;
    await _flutterTts.stop();
    await _flutterTts.speak(text);
  }

  Future<void> dispose() async {
    await _flutterTts.stop();
  }
}
