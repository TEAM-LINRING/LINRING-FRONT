import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginIDController = TextEditingController();
  final loginPasswordController = TextEditingController();
  bool _showError = false;
  void _toggleError() {
    setState(() {
      _showError = !_showError;
    });
  }

  _loginAPI(BuildContext context) async {
    String apiAddress = dotenv.env['API_ADDRESS'] ?? '';
    final url = Uri.parse('$apiAddress/accounts/login/');

    String body = jsonEncode({
      "username": "string",
      "email": '${loginIDController.text}@kookmin.ac.kr',
      "password": loginPasswordController.text,
    });
    print(body);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushNamed(context, '/main');
      } else {
        setState(() {
          _toggleError();
        });
      }
    } catch (error) {
      debugPrint(error.toString());
      setState(() {
        _toggleError();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F4),
      body: Container(

          //background blur img
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/blur2.png'),
            fit: BoxFit.cover,
          )),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 250), // LINRING text
            Text(
              'LINRING',
              style: TextStyle(
                color: Colors.white.withOpacity(0.75),
                fontSize: 55,
                fontWeight: FontWeight.w900,
                height: 0,
                letterSpacing: 1.80,
              ),
            ),

            //너와 나를 잇는 울림 text
            const Text(
              '너와 나를 잇는 울림',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            const SizedBox(height: 70),

            Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
              child: TextField(
                controller: loginIDController,
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
                      child: Text('@kookmin.ac.kr'),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
              child: TextField(
                controller: loginPasswordController,
                obscureText: true,
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
                  hintText: '비밀번호',
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            if (_showError == false)
              const Text(
                '',
                style: TextStyle(fontSize: 15),
              ),
            if (_showError)
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 38),
                  child: Text(
                    '비밀번호가 일치하지 않습니다.',
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  //'입력된 아이디가 존재하지 않습니다.'
                ),
              ),

            const SizedBox(
              height: 30,
            ),
            //로그인 버튼
            CustomOutlinedButton(
                label: '로그인',
                onPressed: () => _loginAPI(context),
                backgroundColor: const Color(0xFFFEC2B5)),

            const SizedBox(
              height: 10,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Spacer(flex: 2),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        "회원가입",
                        style: TextStyle(
                          color: Color(0xFF1B1B1B),
                        ),
                      )),
                  const Spacer(flex: 1),
                  const Text(" | "),
                  const Spacer(flex: 1),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgotPassword');
                      },
                      child: const Text(
                        "비밀번호 찾기",
                        style: TextStyle(
                          color: Color(0xFF1B1B1B),
                        ),
                      )),
                  const Spacer(flex: 2)
                ]),
            const SizedBox(
              height: 100,
            )
          ])),
    );
  }
}
