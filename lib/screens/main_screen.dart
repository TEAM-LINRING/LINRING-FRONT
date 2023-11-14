import 'package:flutter/material.dart';
import 'package:linring_front_flutter/models/login_info.dart';
import 'package:linring_front_flutter/screens/chat_room_screen.dart';
import 'package:linring_front_flutter/screens/setting_screen.dart';
import 'package:linring_front_flutter/screens/tag_show_screen.dart';
import 'package:linring_front_flutter/widgets/custom_bottom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  final LoginInfo loginInfo;
  final int? fixedIndex;

  const MainScreen(this.loginInfo, this.fixedIndex, {super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = widget.fixedIndex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
}
