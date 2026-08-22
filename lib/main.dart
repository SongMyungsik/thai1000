import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(const ThaiLearningApp());
}

class ThaiLearningApp extends StatelessWidget {
  const ThaiLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Thai Learning App',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const SplashScreen(),
    );
  }
}
