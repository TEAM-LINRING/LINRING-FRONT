import 'package:flutter/material.dart';
import 'package:linring_front_flutter/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),
      theme: ThemeData(
        fontFamily: "Pretendard",
      ),
    );
  }
}
