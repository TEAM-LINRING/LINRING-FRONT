import 'package:flutter/material.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';
import 'package:linring_front_flutter/widgets/custom_textfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  bool isPasswordValid = true;
  bool isPasswordConfirmValid = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F4),
      appBar: const CustomAppBar(
        title: '비밀번호 찾기',
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              '다른 사이트에서 사용한 적 없는\n안전한 비밀번호로 변경해주세요.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w300,
                height: 0,
              ),
            ),
            const SizedBox(height: 30),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '새 비밀번호',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: passwordController,
              onChanged: (value) {
                final regex =
                    RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d\W_]{8,}$');

                setState(() {
                  isPasswordValid = regex.hasMatch(value);
                });
              },
              obscureText: true,
              errorText:
                  isPasswordValid ? null : '비밀번호는 영문자와 숫자를 조합해 8자리 이상이어야 합니다.',
            ),
            const SizedBox(height: 20),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '비밀번호 확인',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  isPasswordConfirmValid = passwordController.text == value;
                });
              },
              errorText: isPasswordConfirmValid ? null : '비밀번호가 일치하지 않습니다.',
            ),
            const SizedBox(height: 40),
            CustomOutlinedButton(
              label: '비밀번호 변경하기',
              onPressed: () {},
              backgroundColor: const Color(0xFFFEC2B5),
              isActive: isPasswordValid && isPasswordConfirmValid,
            ),
          ],
        ),
      ),
    );
  }
}
