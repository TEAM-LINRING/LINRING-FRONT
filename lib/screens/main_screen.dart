import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:linring_front_flutter/models/login_info.dart';
import 'package:linring_front_flutter/screens/chat_room_screen.dart';
import 'package:linring_front_flutter/screens/setting_screen.dart';
import 'package:linring_front_flutter/screens/tag_show_screen.dart';
import 'package:linring_front_flutter/widgets/custom_bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  final LoginInfo loginInfo;
  final int? fixedIndex;

  const MainScreen(this.loginInfo, this.fixedIndex, {super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _initFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');

    final fcmToken = await messaging.getToken();

    String apiAddress = dotenv.env['API_ADDRESS'] ?? '';
    final url = Uri.parse('$apiAddress/fcm/devices/');
    final token = widget.loginInfo.access;
    final body = jsonEncode({
      "registration_id": token,
      "active": true,
      "type": "android",
    });

    final result = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );

    print(result.body);
    print(fcmToken);
    messaging.onTokenRefresh.listen((fcmToken) {}).onError((err) {});
  }

  @override
  void initState() {
    _selectedIndex = widget.fixedIndex ?? 0;
    super.initState();
    _initFCM();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleMessage(context, message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      RemoteNotification notification = message.notification!;

      print('Message title: ${notification.title}');
      print('Message body: ${notification.body}');
    });

    return Scaffold(
      body: Stack(
        children: [
          _buildScreen(0, TagShowScreen(loginInfo: widget.loginInfo)),
          _buildScreen(1, ChatRoomScreen(loginInfo: widget.loginInfo)),
          _buildScreen(2, SettingScreen(loginInfo: widget.loginInfo)),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onIndexChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildScreen(int index, Widget screen) {
    return Visibility(
      visible: _selectedIndex == index,
      maintainState: true,
      child: screen,
    );
  }

  void _handleMessage(BuildContext context, RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  }
}
