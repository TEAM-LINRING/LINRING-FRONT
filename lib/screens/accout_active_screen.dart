import 'package:flutter/material.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';
import 'package:url_launcher/url_launcher.dart';

class AccoutActiveScreen extends StatefulWidget {
  final String email;

  const AccoutActiveScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<AccoutActiveScreen> createState() => _AccoutActiveScreenState();
}

class _AccoutActiveScreenState extends State<AccoutActiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F4),
      appBar: const CustomAppBar(
        title: '계정 활성화',
      ),
      body: Container(
        padding:
            const EdgeInsets.only(left: 30.0, top: 30, bottom: 0, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              '아래의 메일로 인증 메일을 보냈어요.\n메일을 확인하여 계정 활성화를 진행해주세요. ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w300,
                height: 0,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: 420,
              height: 70,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFC8AAAA)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                widget.email,
                //'@kookmin.ac.kr',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
            const SizedBox(height: 40),
            CustomOutlinedButton(
                label: 'Gmail로 이동하기',
                onPressed: () {
                  launchUrl(Uri.parse('https://mail.google.com'));
                },
                backgroundColor: const Color(0xFFFEC2B5)),
          ],
        ),
      ),
    );
  }
}
