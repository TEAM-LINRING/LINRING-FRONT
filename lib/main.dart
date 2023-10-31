import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:linring_front_flutter/screens/accout_active_screen.dart';
import 'package:linring_front_flutter/screens/change_password_screen.dart';
import 'package:linring_front_flutter/screens/chat_room_screen.dart';
import 'package:linring_front_flutter/screens/entry_screen.dart';
import 'package:linring_front_flutter/screens/forgot_password_screen.dart';
import 'package:linring_front_flutter/screens/login_screen.dart';
import 'package:linring_front_flutter/screens/profile_screen.dart';
import 'package:linring_front_flutter/screens/report_screen.dart';
import 'package:linring_front_flutter/screens/selectmajor_screen.dart';
import 'package:linring_front_flutter/screens/signup_screen.dart';
import 'package:linring_front_flutter/screens/main_screen.dart';
import 'package:linring_front_flutter/screens/tag_add_screen.dart';

void main() async {
  await dotenv.load(fileName: '.env');
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
        '/signup': (context) => SignUpScreen(),
        '/selectmajor': (context) => SelectMajor(),
        '/main': (context) => const MainScreen(),
        '/add': (context) => const TagAddScreen(),
        '/chat': (context) => const ChatRoomScreen(),
        '/forgotPassword': (context) => const ForgotPasswordScreen(),
        '/changePassword': (context) => const ChangePasswordScreen(),
        '/report': (context) => ReportScreen(),
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/accoutactive') {
          final String email = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => AccoutActiveScreen(email: email),
          );
        }
        return null;
      },
    );
  }
}
