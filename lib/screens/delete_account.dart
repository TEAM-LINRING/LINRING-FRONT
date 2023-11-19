import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:linring_front_flutter/models/login_info.dart';
import 'package:linring_front_flutter/screens/entry_screen.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';
import 'package:linring_front_flutter/widgets/custom_textfield.dart';

class DeleteAccountScreen extends StatefulWidget {
  final LoginInfo loginInfo;
  const DeleteAccountScreen({required this.loginInfo, super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  static const storage = FlutterSecureStorage();
  String password = '';
  bool isIncorrect = false;

  void _deleteAccount(BuildContext context) async {
    String apiAddress = dotenv.env['API_ADDRESS'] ?? '';
    final url =
        Uri.parse('$apiAddress/accounts/v2/user/${widget.loginInfo.user.id}/');
    final token = widget.loginInfo.access;

    final response = await http.delete(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "password": password,
        }));
    debugPrint((response.statusCode).toString());
    if (response.statusCode == 204) {
      password = '';

      if (!mounted) return;
      storage.delete(key: 'user');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EntryScreen(),
        ),
      );
    } else if (response.statusCode == 400) {
      setState(() {
        isIncorrect = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F4),
      appBar: CustomAppBar(
        title: '탈퇴하기',
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(left: 20, top: 15, bottom: 0, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '계정을 삭제하기 전에 필독해주세요.',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '설정된 모든 태그과 채팅이 삭제됩니다.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '이벤트 참여 내역과 같은 모든 활동 정보가 삭제됩니다.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '계정이 삭제된 후에는 계정을 다시 살리거나 채팅 등의 데이터를 복구 할 수 없습니다.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '현재 계정으로 다시는 로그인 할 수 없습니다.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '다른 사용자에게 보낸 채팅 등 일부 정보는 계속 남아있을 수 있습니다.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
                text: const TextSpan(children: [
              TextSpan(
                text: '비밀번호 입력 후, 아래의 탈퇴하기 버튼을 누르면 본 계정이 ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: '영구히 삭제됩니다.',
                style: TextStyle(
                  color: Color(0xFFFF0000),
                  fontSize: 20,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              )
            ])),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: CustomTextField(
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                errorText: isIncorrect ? '비밀번호가 일치하지 않습니다.' : null,
              ),
            ),
            OutlinedButton(
              onPressed: () {
                _deleteAccount(context);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xFFFF0000),
                side: const BorderSide(width: 1, color: Color(0xFFC8AAAA)),
                elevation: 5,
                shadowColor: const Color(0x196C5916),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: const Size(350, 70),
              ),
              child: const Text(
                '탈퇴하기',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  height: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
