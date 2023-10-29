import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:linring_front_flutter/models/login_info.dart';
import 'package:linring_front_flutter/screens/chat_room_screen.dart';
import 'package:linring_front_flutter/screens/setting_screen.dart';
import 'package:linring_front_flutter/screens/tag_show_screen.dart';
import 'package:linring_front_flutter/widgets/custom_bottom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // FlutterSecureStroage 객체를 storage 변수에 할당
  static const storage = FlutterSecureStorage();
  // storage에 존재하는 로그인 된 User 정보를 받아올 변수, 공백으로 초기화
  dynamic loginInfo = '';

  static const List<Widget> _screens = <Widget>[
    TagShowScreen(),
    ChatRoomScreen(),
    SettingScreen(),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String? res = await storage.read(key: 'user');

      if (res == null) {
        // 로그인 만료 및 로그인 필요 안내 출력 후 페이지 이동
        Navigator.pushNamed(context, '/');
      } else {
        // res != null
        final Map parsed = json.decode(res);
        loginInfo = LoginInfo.fromJson(parsed);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onIndexChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _screens[_selectedIndex],
    );
  }
}
