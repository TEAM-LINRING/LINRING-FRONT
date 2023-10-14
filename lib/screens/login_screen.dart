import 'package:flutter/material.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';
import 'package:linring_front_flutter/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginIDController = TextEditingController();
  final loginPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F4),
      appBar: const CustomAppBar(title: '로그인'),
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
            const Spacer(
              flex: 1,
            ),
            // LINRING text
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
            const Spacer(
              flex: 1,
            ),

            CustomTextField(
              controller: loginIDController,
              obscureText: false,
              //hintText: '이메일을 입력하세요',
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
            CustomTextField(
              controller: loginPasswordController,
              hintText: '비밀번호',
              obscureText: true,
            ),
            const Spacer(flex: 1),

            //로그인 버튼
            CustomOutlinedButton(
                label: '로그인',
                onPressed: () {},
                backgroundColor: const Color(0xFFFEC2B5)),

            const SizedBox(
              height: 10,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Spacer(flex: 2),
                  TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                      child: const Text(
                        "아이디 찾기",
                        style: TextStyle(
                          color: Color(0xFF1B1B1B),
                        ),
                      )),
                  const Spacer(flex: 1),
                  const Text(" | "),
                  const Spacer(flex: 1),
                  TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                      child: const Text(
                        "비밀번호 찾기",
                        style: TextStyle(
                          color: Color(0xFF1B1B1B),
                        ),
                      )),
                  const Spacer(flex: 2)
                ]),

            const Spacer(
              flex: 1,
            )
          ])),
    );
  }
}
