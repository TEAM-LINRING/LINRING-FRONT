import 'package:flutter/material.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

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
            image: AssetImage('assets/images/blur1.png'),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Spacer(
                flex: 2,
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

              //로그인 버튼
              const Spacer(
                flex: 1,
              ),

              //로그인 버튼
              CustomOutlinedButton(
                label: '로그인',
                onPressed: () => {
                  Navigator.pushNamed(context, '/login'),
                },
                backgroundColor: Colors.white,
                isActive: true,
              ),

              const SizedBox(
                height: 10,
              ),

              //회원가입 버튼
              CustomOutlinedButton(
                label: '회원가입',
                onPressed: () => {Navigator.pushNamed(context, '/signup')},
                backgroundColor: const Color(0xFFFEC2B5),
                isActive: true,
              ),
              const Spacer(
                flex: 1,
              )
            ]),
          )),
    );
  }
}
