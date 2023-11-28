import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:linring_front_flutter/firebase_options.dart';
import 'package:linring_front_flutter/screens/accout_active_screen.dart';
import 'package:linring_front_flutter/screens/change_password_screen.dart';
import 'package:linring_front_flutter/screens/entry_screen.dart';
import 'package:linring_front_flutter/screens/forgot_password_screen.dart';
import 'package:linring_front_flutter/screens/login_screen.dart';
import 'package:linring_front_flutter/screens/password_email_verify_screen.dart';
import 'package:linring_front_flutter/screens/selectmajor_screen.dart';
import 'package:linring_front_flutter/screens/signup_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

// final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel',
//   'High Importance Notifications',
//   importance: Importance.high,
// );

@pragma('vm:entry-point')
void main() async {
  await initializeDateFormatting("ko_KR", null);
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /*
  (23.11.25)
  아래 두 가지 문제가 발생하여 임시로 주석 처리합니다.
  
  1. foreground message와 background message를 동시에 받게 되어 ChatScreen에서 message가 여러 개 생성됨
  2. android에서 background message를 수신할 경우, notification을 show 하는 과정에서 NullPointer 에러 발생
  */

  // FirebaseMessaging.onBackgroundMessage(onBackgroundHandler);
  // await _initNotification();

  runApp(const MyApp());
}

// Future<void> _initNotification() async {
//   // 안드로이드 초기 설정
//   const AndroidInitializationSettings initSettingAndroid =
//       AndroidInitializationSettings("@mipmap/launcher_icon");

//   // iOS 초기 설정
//   const DarwinInitializationSettings initSettingIOS =
//       DarwinInitializationSettings(
//     requestSoundPermission: true,
//     requestBadgePermission: true,
//     requestAlertPermission: true,
//   );

//   const InitializationSettings initSettings = InitializationSettings(
//     android: initSettingAndroid,
//     iOS: initSettingIOS,
//   );

//   await flutterLocalNotificationsPlugin.initialize(initSettings);
// }

// Background FCM handler
// Future onBackgroundHandler(RemoteMessage message) async {
//   print('IN BACKGROUND HANDLER');
//   Map<String, dynamic> data = message.data;

//   String? title = '새로운 채팅';
//   String? body = '채팅 내용입니다.';

//   // if (data['type'] == 1) {
//   //   body = data['message'];
//   // }
//   // if (data['type'] == 2) {
//   //   body = data['args'];
//   // }

//   // 알림이 있고, 앱이 백그라운드 상태에서 실행되고 있는 경우에만 알림을 표시
//   flutterLocalNotificationsPlugin.show(
//       message.hashCode,
//       title,
//       body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//         ),
//       ));

//   print("END NOTIFICATION SHOWING");

//   return Future.value();
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const EntryScreen(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        fontFamily: "Pretendard",
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/selectmajor': (context) => SelectMajor(),
        '/forgotPassword': (context) => const ForgotPasswordScreen(),
        '/emailVerify': (context) => const PasswordEmailVerifyScreen(),
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
