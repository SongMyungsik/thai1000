// Basic widget tests for the Thai learning app.
//
// These verify the splash screen, the bottom-nav shell, and each section
// screen render and navigate correctly, since flutter_tts calls are not
// exercised in widget tests (no platform channel available in the test
// environment).

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:thai1000/main.dart';

/// Pumps the app and taps past the splash screen into the bottom-nav shell
/// (starts on the "홈" tab), since most tests below exercise the shell.
Future<void> _pumpToHome(WidgetTester tester) async {
  await tester.pumpWidget(const ThaiLearningApp());
  await tester.tap(find.text('시작하기'));
  await tester.pumpAndSettle();
}

/// The bottom NavigationBar's items overlap in text with some tab screens'
/// own AppBar titles (both stay mounted under IndexedStack), so navigation
/// taps are scoped to the NavigationBar specifically.
Finder _navLabel(String label) => find.descendant(
  of: find.byType(NavigationBar),
  matching: find.text(label),
);

Future<void> _goToTab(WidgetTester tester, String label) async {
  await tester.tap(_navLabel(label));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Splash screen shows the title, consonants, and version', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ThaiLearningApp());

    expect(find.text('태국어를 공부하자'), findsOneWidget);
    expect(find.text('ก'), findsOneWidget);
    expect(find.text('ข'), findsOneWidget);
    expect(find.text('시작하기'), findsOneWidget);
    expect(find.text('태국어 학습 앱 ver. 1.0'), findsOneWidget);
  });

  testWidgets('Tapping 시작하기 opens the home dashboard with a bottom nav bar', (
    WidgetTester tester,
  ) async {
    await _pumpToHome(tester);

    expect(find.text('안녕하세요! 👋'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    for (final label in ['홈', '자음모음', '단어', '성조', '회화', '퀴즈']) {
      expect(_navLabel(label), findsOneWidget);
    }
  });

  testWidgets('Bottom nav switches to the consonant/vowel tab with sub-tabs', (
    WidgetTester tester,
  ) async {
    await _pumpToHome(tester);

    await _goToTab(tester, '자음모음');

    expect(find.text('자음모음'), findsWidgets);
    expect(find.text('ก'), findsOneWidget);
    expect(find.text('Ko Kai'), findsOneWidget);

    final vowelSubTab = find.descendant(
      of: find.byType(TabBar),
      matching: find.text('모음'),
    );
    await tester.tap(vowelSubTab);
    await tester.pumpAndSettle();

    expect(find.text('◌า'), findsOneWidget);
  });

  testWidgets('Consonant/vowel screen has a Korean-order sub-tab that opens a detail', (
    WidgetTester tester,
  ) async {
    await _pumpToHome(tester);
    await _goToTab(tester, '자음모음');

    final koreanSubTab = find.descendant(
      of: find.byType(TabBar),
      matching: find.text('한글순'),
    );
    await tester.tap(koreanSubTab);
    await tester.pumpAndSettle();

    expect(find.text('ㄱ/ㄲ'), findsOneWidget);
    expect(find.text('ㄷ'), findsOneWidget);
    expect(find.text('ㄸ'), findsOneWidget);

    await tester.tap(find.text('ก').first);
    await tester.pumpAndSettle();

    expect(find.text('초성일 때 소리'), findsOneWidget);
  });

  testWidgets('Tapping a consonant opens its detail screen and hides the nav bar', (
    WidgetTester tester,
  ) async {
    await _pumpToHome(tester);
    await _goToTab(tester, '자음모음');

    await tester.tap(find.text('ก'));
    await tester.pumpAndSettle();

    expect(find.text('초성일 때 소리'), findsOneWidget);
    expect(find.text('종성(받침)일 때 소리'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('Bottom nav switches to the word tab and opens a detail', (
    WidgetTester tester,
  ) async {
    await _pumpToHome(tester);
    await _goToTab(tester, '단어');

    expect(find.text('สวัสดี'), findsOneWidget);

    await tester.tap(find.text('สวัสดี'));
    await tester.pumpAndSettle();

    expect(find.text('음절 분해'), findsOneWidget);
  });

  testWidgets(
    'Tapping a syllable part in a word detail opens the linked consonant',
    (WidgetTester tester) async {
      await _pumpToHome(tester);
      await _goToTab(tester, '단어');
      await tester.tap(find.text('สวัสดี'));
      await tester.pumpAndSettle();

      final target = find.text('초성 ด').first;
      await tester.ensureVisible(target);
      await tester.pumpAndSettle();
      await tester.tap(target);
      await tester.pumpAndSettle();

      expect(find.text('초성일 때 소리'), findsOneWidget);
    },
  );

  testWidgets(
    'Bottom nav switches to the conversation tab and links back to a word',
    (WidgetTester tester) async {
      await _pumpToHome(tester);
      await _goToTab(tester, '회화');

      expect(find.text('인사 나누기'), findsWidgets);

      await tester.tap(find.text('인사 나누기').last);
      await tester.pumpAndSettle();

      final wordChip = find.text('สวัสดี').first;
      await tester.ensureVisible(wordChip);
      await tester.pumpAndSettle();
      await tester.tap(wordChip);
      await tester.pumpAndSettle();

      expect(find.text('음절 분해'), findsOneWidget);
    },
  );

  testWidgets('Bottom nav switches to the tone tab and opens the rules table', (
    WidgetTester tester,
  ) async {
    await _pumpToHome(tester);
    await _goToTab(tester, '성조');

    final rulesCard = find.text('성조 규칙표');
    await tester.ensureVisible(rulesCard);
    await tester.pumpAndSettle();
    await tester.tap(rulesCard);
    await tester.pumpAndSettle();
    expect(find.text('성조 부호가 없을 때'), findsOneWidget);
  });

  testWidgets('Tone calculator updates the result when the class changes', (
    WidgetTester tester,
  ) async {
    await _pumpToHome(tester);
    await _goToTab(tester, '성조');

    final calculatorCard = find.text('성조 계산기');
    await tester.ensureVisible(calculatorCard);
    await tester.pumpAndSettle();
    await tester.tap(calculatorCard);
    await tester.pumpAndSettle();
    expect(find.text('평성 (사만)'), findsOneWidget);

    await tester.tap(find.text('고자음'));
    await tester.pumpAndSettle();
    expect(find.text('올라가는 성조 (짜따와)'), findsOneWidget);
  });

  testWidgets('Word detail syllables show a computed tone chip', (
    WidgetTester tester,
  ) async {
    await _pumpToHome(tester);
    await _goToTab(tester, '단어');
    await tester.tap(find.text('สวัสดี'));
    await tester.pumpAndSettle();

    expect(find.textContaining('평성'), findsWidgets);
  });

  testWidgets('Bottom nav switches to the quiz tab showing all four cards', (
    WidgetTester tester,
  ) async {
    await _pumpToHome(tester);
    await _goToTab(tester, '퀴즈');

    expect(find.text('자음 퀴즈'), findsOneWidget);
    expect(find.text('모음 퀴즈'), findsOneWidget);
    expect(find.text('단어 퀴즈'), findsOneWidget);
    expect(find.text('성조 퀴즈'), findsOneWidget);
  });

  testWidgets('Playing through the tone quiz shows a final score screen', (
    WidgetTester tester,
  ) async {
    await _pumpToHome(tester);
    await _goToTab(tester, '퀴즈');
    await tester.tap(find.text('성조 퀴즈'));
    await tester.pumpAndSettle();

    for (var i = 0; i < 10; i++) {
      expect(find.byType(OutlinedButton), findsWidgets);
      final option = find.byType(OutlinedButton).first;
      await tester.ensureVisible(option);
      await tester.pumpAndSettle();
      await tester.tap(option);
      await tester.pumpAndSettle();

      expect(find.byType(FilledButton), findsOneWidget);
      final nextButton = find.byType(FilledButton);
      await tester.ensureVisible(nextButton);
      await tester.pumpAndSettle();
      await tester.tap(nextButton);
      await tester.pumpAndSettle();
    }

    expect(find.textContaining('/ 10 문제 정답'), findsOneWidget);

    await tester.tap(find.text('다시 풀기'));
    await tester.pumpAndSettle();
    expect(find.byType(OutlinedButton), findsWidgets);
  });

  testWidgets('Guide screen is reachable from the home tab app bar', (
    WidgetTester tester,
  ) async {
    await _pumpToHome(tester);

    await tester.tap(find.byIcon(Icons.help_outline));
    await tester.pumpAndSettle();

    expect(find.text('학습 가이드'), findsOneWidget);
  });
}
