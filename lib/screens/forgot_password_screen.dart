import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:linring_front_flutter/screens/change_password_screen.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  _sendEmail() async {
    String apiAddress = dotenv.env['API_ADDRESS'] ?? '';
    final url = Uri.parse('$apiAddress/accounts/password/reset/');

    String body = jsonEncode({
      "email": '${emailController.text}@kookmin.ac.kr',
    });

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final String res = utf8.decode(response.bodyBytes);
      return true;
    }
  }

  final emailController = TextEditingController();
  bool emailNotNull = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(
      () {
        (emailController.text != "")
            ? emailNotNull = true
            : emailNotNull = false;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F4),
      appBar: const CustomAppBar(
        title: '비밀번호 찾기',
      ),
      body: Container(
        padding:
            const EdgeInsets.only(left: 30.0, top: 30, bottom: 0, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              '회원가입시 등록한 국민대 웹메일로\n비밀번호를 변경할 수 있습니다.',
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
                  '국민대 웹메일',
                  style: TextStyle(fontSize: 22),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: TextField(
                controller: emailController,
                obscureText: false,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Color(0xFFC8AAAA)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Color(0xFFC8AAAA)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Align(
                      alignment: Alignment.center,
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Text(
                        '@kookmin.ac.kr',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            CustomOutlinedButton(
              label: '인증 메일 받기',
              onPressed: () {
                _sendEmail();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePasswordScreen()));
              },
              isActive: emailNotNull,
              backgroundColor: const Color(0xFFFEC2B5),
            ),
          ],
        ),
      ),
    );
  }
}
