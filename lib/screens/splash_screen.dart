import 'package:flutter/material.dart';

import 'home_shell_screen.dart';

const _thaiFlagRed = Color(0xFFA51931);
const _thaiFlagWhite = Color(0xFFF4F5F8);
const _thaiFlagBlue = Color(0xFF2D2A4A);

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1번째 줄(빨강): 비워둠.
            const Expanded(child: ColoredBox(color: _thaiFlagRed)),
            // 2번째 줄(하양): 헤드라인.
            Expanded(
              child: ColoredBox(
                color: _thaiFlagWhite,
                child: const Center(
                  child: Text(
                    '태국어를 공부하자',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: _thaiFlagBlue,
                    ),
                  ),
                ),
              ),
            ),
            // 3번째 줄(파랑, 2배 높이): 태국어 자음 두 글자.
            Expanded(
              flex: 2,
              child: ColoredBox(
                color: _thaiFlagBlue,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'ก',
                        style: TextStyle(
                          fontSize: 130.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 24.0),
                      Text(
                        'ข',
                        style: TextStyle(
                          fontSize: 130.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // 4번째 줄(하양): 시작하기 버튼.
            Expanded(
              child: ColoredBox(
                color: _thaiFlagWhite,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const HomeShellScreen(),
                            ),
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        child: const Text(
                          '시작하기',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // 5번째 줄(빨강): 버전 정보.
            Expanded(
              child: ColoredBox(
                color: _thaiFlagRed,
                child: const Center(
                  child: Text(
                    '태국어 학습 앱 ver. 1.0',
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
