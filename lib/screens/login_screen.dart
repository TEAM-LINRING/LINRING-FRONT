import 'package:flutter/material.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';
import 'package:linring_front_flutter/widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Color(0xFFFFF6F4),
      //appBar: CustomAppBar(title: '로그인'),
      appBar: AppBar(
        title: Text(
          '로그인',
          style: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              height: 0),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => {
                  if (Navigator.of(context).canPop())
                    {Navigator.of(context).pop()} //뒤로가기
                },
            color: const Color.fromARGB(255, 0, 0, 0),
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
          //background blur img
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('lib/images/blur2.png'),
            fit: BoxFit.cover,
          )),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Spacer(
              flex: 1,
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
            Spacer(
              flex: 1,
            ),

            CustomTextField(
              controller: emailController,
              obscureText: false,
              //hintText: '이메일을 입력하세요',
              suffixText: Text('@kookmin.ac.kr'),
            ),
            CustomTextField(
              controller: passwordController,
              hintText: '비밀번호를 입력하세요',
              obscureText: true,
            ),
            Spacer(flex: 1),

            //로그인 버튼
            CustomOutlinedButton(
                label: '로그인',
                onPressed: () {},
                backgroundColor: Color(0xFFFEC2B5)),

            SizedBox(
              height: 10,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Spacer(flex: 2),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "아이디 찾기",
                        style: TextStyle(
                          color: Color(0xFF1B1B1B),
                        ),
                      ),
                      style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap)),
                  Spacer(flex: 1),
                  Text(" | "),
                  Spacer(flex: 1),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "비밀번호 찾기",
                        style: TextStyle(
                          color: Color(0xFF1B1B1B),
                        ),
                      ),
                      style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap)),
                  Spacer(flex: 2)
                ]),

            Spacer(
              flex: 1,
            )
          ])),
    ));
  }
}
