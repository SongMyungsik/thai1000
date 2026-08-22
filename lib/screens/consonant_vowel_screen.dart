import 'package:flutter/material.dart';

import '../services/tts_service.dart';
import 'consonants_screen.dart';
import 'korean_order_tab.dart';
import 'vowels_screen.dart';

/// "자음모음" 탭: 상단 서브탭(TabBar)으로 자음/모음/한글순을 나눈다.
class ConsonantVowelScreen extends StatelessWidget {
  const ConsonantVowelScreen({super.key, required this.tts});

  final TtsService tts;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('자음모음'),
          bottom: const TabBar(
            tabs: [Tab(text: '자음'), Tab(text: '모음'), Tab(text: '한글순')],
          ),
        ),
        body: TabBarView(
          children: [
            ConsonantsTabBody(tts: tts),
            VowelsTabBody(tts: tts),
            KoreanOrderTab(tts: tts),
          ],
        ),
      ),
    );
  }
}
