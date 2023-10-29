import 'package:flutter/material.dart';
import 'package:linring_front_flutter/models/login_info.dart';

class SettingScreen extends StatelessWidget {
  final LoginInfo loginInfo;
  const SettingScreen({required this.loginInfo,super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      child: Text("Setting Screen"),
    );
  }
}
