import 'package:flutter/material.dart';

import '../services/tts_service.dart';

/// 발음이 안 나올 때 실제로 무슨 일이 일어나는지 화면에서 바로 보여주는
/// 진단 화면. 스크린샷 한 장으로 원인을 파악할 수 있게 하는 것이 목적이다.
class TtsDiagnosticsScreen extends StatefulWidget {
  const TtsDiagnosticsScreen({super.key, required this.tts});

  final TtsService tts;

  @override
  State<TtsDiagnosticsScreen> createState() => _TtsDiagnosticsScreenState();
}

class _TtsDiagnosticsScreenState extends State<TtsDiagnosticsScreen> {
  @override
  void initState() {
    super.initState();
    widget.tts.onDiagnosticsUpdate = () {
      if (mounted) setState(() {});
    };
  }

  @override
  void dispose() {
    widget.tts.onDiagnosticsUpdate = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final voices = widget.tts.voiceSummaries;
    final thaiVoices = voices.where((v) => v.toLowerCase().contains('th')).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('TTS 문제 진단')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _Section(
            title: '1. speechSynthesis 지원 여부',
            child: Text(widget.tts.isSupported ? '✅ 지원됨' : '❌ 지원 안 됨'),
          ),
          const SizedBox(height: 16.0),
          _Section(
            title: '2. 태국어로 보이는 음성 (lang에 "th" 포함)',
            child: thaiVoices.isEmpty
                ? const Text('⚠️ 없음 — 이게 원인일 가능성이 높습니다')
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [for (final v in thaiVoices) Text(v)],
                  ),
          ),
          const SizedBox(height: 16.0),
          _Section(
            title: '3. 전체 음성 목록 (${voices.length}개)',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final v in voices)
                  Text(v, style: const TextStyle(fontSize: 12.0)),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          FilledButton.icon(
            onPressed: () => widget.tts.speak('ทดสอบเสียง'),
            icon: const Icon(Icons.volume_up),
            label: const Text('지금 테스트 재생 (ทดสอบเสียง)'),
          ),
          const SizedBox(height: 16.0),
          _Section(
            title: '4. 실행 로그 (아래로 갈수록 최신)',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.tts.diagnosticsLog.isEmpty)
                  const Text('(아직 없음 — 위 재생 버튼을 눌러보세요)'),
                for (final line in widget.tts.diagnosticsLog)
                  Text(line, style: const TextStyle(fontSize: 12.0)),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
          const Text(
            '이 화면 전체를 스크린샷으로 찍어서 보내주시면 원인 파악에 도움이 됩니다.',
            style: TextStyle(fontSize: 12.0, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8.0),
            child,
          ],
        ),
      ),
    );
  }
}
