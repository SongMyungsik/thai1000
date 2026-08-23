import 'package:flutter/material.dart';

import '../services/tts_service.dart';
import 'consonant_vowel_screen.dart';
import 'conversations_screen.dart';
import 'home_dashboard_screen.dart';
import 'quiz_screen.dart';
import 'tone_screen.dart';
import 'words_screen.dart';

/// 앱의 새 진입점. 하단 내비게이션 바로 6개 섹션을 전환한다.
/// 상세/플레이 화면은 지금처럼 Navigator.push로 전체 화면을 덮어써서
/// 자연스럽게 하단 바가 사라지고, 뒤로가기로 돌아오면 다시 나타난다.
class HomeShellScreen extends StatefulWidget {
  const HomeShellScreen({super.key});

  @override
  State<HomeShellScreen> createState() => _HomeShellScreenState();
}

class _HomeShellScreenState extends State<HomeShellScreen> {
  final TtsService _tts = TtsService();
  int _selectedIndex = 0;

  @override
  void dispose() {
    _tts.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      HomeDashboardScreen(tts: _tts),
      ConsonantVowelScreen(tts: _tts),
      WordsScreen(tts: _tts),
      ToneScreen(tts: _tts),
      ConversationsScreen(tts: _tts),
      QuizScreen(tts: _tts),
    ];

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: '홈'),
          NavigationDestination(icon: Icon(Icons.abc), label: '자음모음'),
          NavigationDestination(icon: Icon(Icons.menu_book), label: '단어'),
          NavigationDestination(icon: Icon(Icons.music_note), label: '성조'),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            label: '회화',
          ),
          NavigationDestination(icon: Icon(Icons.quiz_outlined), label: '퀴즈'),
        ],
      ),
    );
  }
}
