import 'package:flutter/material.dart';
import 'package:linring_front_flutter/screens/entry_screen.dart';
import 'package:linring_front_flutter/screens/login_screen.dart';
import 'package:linring_front_flutter/screens/selectmajor_screen.dart';
import 'package:linring_front_flutter/screens/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EntryPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/selectmajor': (context) => SelectMajor(),
      },
    );
  }
}
