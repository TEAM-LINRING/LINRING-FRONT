import 'package:flutter/material.dart';
import 'package:linring_front_flutter/screens/chat_screen.dart';
import 'package:linring_front_flutter/screens/entry_screen.dart';
import 'package:linring_front_flutter/screens/login_screen.dart';
import 'package:linring_front_flutter/screens/selectmajor_screen.dart';
import 'package:linring_front_flutter/screens/signup_screen.dart';
import 'package:linring_front_flutter/screens/main_screen.dart';
import 'package:linring_front_flutter/screens/tag_add_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const EntryScreen(),
      theme: ThemeData(
        fontFamily: "Pretendard",
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/selectmajor': (context) => SelectMajor(),
        '/main': (context) => const MainScreen(),
        '/add': (context) => const TagAddScreen(),
        '/chat': (context) => const ChatScreen(),
      },
    );
  }
}
