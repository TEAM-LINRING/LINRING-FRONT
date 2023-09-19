import 'package:flutter/material.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFFFF6F4),
        body: Container(

            //background blur img
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('lib/images/blur.png'),
              fit: BoxFit.cover,
            )),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Spacer(
                flex: 2,
              ),

              // LINRING text
              Text(
                'LINRING',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 55,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w900,
                  height: 0,
                  letterSpacing: 1.80,
                ),
              ),

              //너와 나를 잇는 울림 text
              Text(
                '너와 나를 잇는 울림',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),

              //로그인 버튼
              Spacer(
                flex: 1,
              ),

              //로그인 버튼
              CustomOutlinedButton(
                  label: '로그인',
                  onPressed: () {},
                  backgroundColor: Colors.white),

              SizedBox(
                height: 10,
              ),

              //회원가입 버튼
              CustomOutlinedButton(
                  label: '회원가입',
                  onPressed: () {},
                  backgroundColor: Color(0xFFFEC2B5)),
              Spacer(
                flex: 1,
              )
            ])),
      ),
    );
  }
}
