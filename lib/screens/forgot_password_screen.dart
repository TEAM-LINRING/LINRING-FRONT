import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:linring_front_flutter/screens/change_password_screen.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF6F4),
        appBar: CustomAppBar(
          title: '비밀번호 찾기',
        ),
        body: Container(
          padding:
              const EdgeInsets.only(left: 30.0, top: 30, bottom: 0, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                '계정 비밀번호가 기억나지 않으신가요?\n링링 웹 메일로 문의를 넣어주시면\n비밀번호 찾기 및 변경을 도와드려요.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w300,
                  height: 0,
                ),
              ),
              const SizedBox(height: 50),
              const Row(
                children: [
                  Text(
                    '링링 웹메일',
                    style: TextStyle(fontSize: 22),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffc8aaaa)),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 40,
                ),
                child: const Text(
                  "teamlinring@gmail.com",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              CustomOutlinedButton(
                label: 'Gmail로 이동하기',
                onPressed: () {
                  launchUrl(Uri.parse('https://mail.google.com'));
                },
                backgroundColor: const Color(0xFFFEC2B5),
                isActive: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
