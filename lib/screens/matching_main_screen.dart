import 'dart:math';
import 'package:vector_math/vector_math.dart' show radians;
import 'package:flutter/material.dart';

class MatchingMainScreen extends StatefulWidget {
  const MatchingMainScreen({super.key});

  @override
  State<MatchingMainScreen> createState() => _MatchingMainScreenState();
}

class _MatchingMainScreenState extends State<MatchingMainScreen> {
  final radius1 = 100;
  final radius4 = 150;
  final radius2 = 200;
  final radius3 = 300;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/matching_main_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
            child: Center(
                child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/loading.gif'),
            const SizedBox(
              height: 5,
            ),
            Transform(
              transform: Matrix4.identity()
                ..translate(
                    radius4 * cos(radians(30)), radius4 * sin(radians(120))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/character/char_pudding.png'),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text('닉네임1')
                ],
              ),
            ),
            Transform(
              transform: Matrix4.identity()
                ..translate(
                    radius3 * cos(radians(90)), radius3 * sin(radians(60))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/character/char_pudding.png'),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text('닉네임2')
                ],
              ),
            ),
            Transform(
              transform: Matrix4.identity()
                ..translate(
                    radius2 * cos(radians(250)), radius2 * sin(radians(270))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/character/char_pudding.png'),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text('닉네임3')
                ],
              ),
            ),
            Transform(
              transform: Matrix4.identity()
                ..translate(
                    radius2 * cos(radians(220)), radius2 * sin(radians(0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/character/char_pudding.png'),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text('닉네임4')
                ],
              ),
            )
          ],
        ))),
      ),
    );
  }
}
