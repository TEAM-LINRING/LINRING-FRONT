import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:linring_front_flutter/models/login_info.dart';
import 'package:linring_front_flutter/screens/main_screen.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // FlutterSecureStroage 객체를 storage 변수에 할당
  static const storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String? res = await storage.read(key: 'user');

      if (res != null) {
        final Map parsed = json.decode(utf8.decode(res.codeUnits));
        final loginInfo = LoginInfo.fromJson(parsed);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(loginInfo, 0),
          ),
        );
      }
    });
  }

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
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final String res = response.body;
        await storage.write(key: 'user', value: res);
        return true;
      } else {
        setState(() {
          _toggleError();
        });
        return false;
      }
    } catch (error) {
      setState(() {
        _toggleError();
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //background blur img
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/login_bg.png'),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // backgroundColor: const Color(0xFFFFF6F4),
        backgroundColor: Colors.transparent,
        body: Stack(children: <Widget>[
          SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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

              const Text(
                '너와 나를 잇는 울림, 링링',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),

              const SizedBox(height: 70),

              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
                    hintText: '아이디',
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomOutlinedButton(
                  label: '로그인',
                  onPressed: () async {
                    bool loginSuccessful = await _loginAPI(context);

                    if (loginSuccessful) {
                      String? res = await storage.read(key: 'user');

                      if (res != null) {
                        final String decodedString = utf8.decode(res.codeUnits);
                        final Map parsed = json.decode(decodedString);
                        final loginInfo = LoginInfo.fromJson(parsed);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(loginInfo, 0),
                          ),
                        );
                      }
                    }
                  },
                  backgroundColor: const Color(0xFFFEC2B5),
                  isActive: true,
                ),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: const Text(
                              "회원가입",
                              style: TextStyle(
                                color: Color(0xFF1B1B1B),
                              ),
                            )),
                      ),
                      const Text(
                        " | ",
                        style: TextStyle(color: Color(0xFFC8AAAA)),
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/forgotPassword');
                            },
                            child: const Text(
                              "비밀번호 찾기",
                              style: TextStyle(
                                color: Color(0xFF1B1B1B),
                              ),
                            )),
                      ),
                    ]),
              ),
              const SizedBox(
                height: 100,
              )
            ]),
          ),
        ]),
      ),
    );
  }
}
