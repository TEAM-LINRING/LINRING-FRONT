import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:linring_front_flutter/firebase_options.dart';
import 'package:linring_front_flutter/screens/accout_active_screen.dart';
import 'package:linring_front_flutter/screens/change_password_screen.dart';
import 'package:linring_front_flutter/screens/entry_screen.dart';
import 'package:linring_front_flutter/screens/forgot_password_screen.dart';
import 'package:linring_front_flutter/screens/login_screen.dart';
import 'package:linring_front_flutter/screens/selectmajor_screen.dart';
import 'package:linring_front_flutter/screens/signup_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:linring_front_flutter/utils/dynamic_links.dart';

void main() async {
  await initializeDateFormatting("ko_KR", null);
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  DynamicLinkService.instance.createDynamicLink();
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
        '/forgotPassword': (context) => const ForgotPasswordScreen(),
        '/changePassword': (context) => const ChangePasswordScreen(),
        //'/report': (context) => ReportScreen(loginInfo: ,),
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
