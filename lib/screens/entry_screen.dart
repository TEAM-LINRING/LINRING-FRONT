import 'package:flutter/material.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_widget.dart';

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
              // OutlinedButton(
              //   onPressed: () {
              //     // 버튼이 눌렸을 때의 액션을 여기에 넣어주세요.
              //   },
              //   style: OutlinedButton.styleFrom(
              //     primary: Colors.black, // 텍스트 색상
              //     backgroundColor: Colors.white, // 배경 색상
              //     side: BorderSide.none, // 테두리 없애기
              //     elevation: 5, // 그림자 높이
              //     shadowColor: Color(0x196C5916), // 그림자 색상
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     fixedSize: Size(350, 75),
              //   ),
              //   child: Text(
              //     '로그인',
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 24,
              //       fontFamily: 'Pretendard',
              //       fontWeight: FontWeight.w400,
              //       height: 0,
              //     ),
              //   ),
              // ),
              CustomOutlinedButton(
                  label: '로그인',
                  onPressed: () {},
                  backgroundColor: Colors.white),
              SizedBox(
                height: 10,
              ),

              //회원가입 버튼
              // OutlinedButton(
              //   onPressed: () {
              //     // 버튼이 눌렸을 때의 액션을 여기에 넣어주세요.
              //   },
              //   style: OutlinedButton.styleFrom(
              //     primary: Colors.black, // 텍스트 색상
              //     backgroundColor: Color(0xFFFEC2B5), // 배경 색상
              //     side: BorderSide.none, // 테두리 없애기
              //     elevation: 5, // 그림자 높이
              //     shadowColor: Color(0x196C5916), // 그림자 색상
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     fixedSize: Size(350, 75),
              //   ),
              //   child: Text(
              //     '회원가입',
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 24,
              //       fontFamily: 'Pretendard',
              //       fontWeight: FontWeight.w400,
              //       height: 0,
              //     ),
              //   ),
              // ),
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
