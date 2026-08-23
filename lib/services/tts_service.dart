import 'tts_platform.dart';

/// 기기에 설치된 태국어 TTS 음성으로 글자/단어를 읽어준다. 실제 구현은
/// 플랫폼별로 다르다(웹은 브라우저 Web Speech API 직접 호출, 그 외는
/// flutter_tts) — [tts_platform.dart] 참고.
class TtsService {
  final TtsPlatform _platform = TtsPlatform();

  void speak(String text) => _platform.speak(text);

  Future<void> dispose() => _platform.dispose();

  // 아래는 "TTS 문제 진단" 화면 전용. 평소 화면에서는 쓰이지 않는다.
  bool get isSupported => _platform.isSupported;
  List<String> get voiceSummaries => _platform.voiceSummaries;
  List<String> get diagnosticsLog => _platform.log;
  set onDiagnosticsUpdate(void Function()? callback) =>
      _platform.onLogUpdate = callback;
}
