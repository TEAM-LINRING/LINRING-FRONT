import 'dart:math';
import 'package:flutter_svg/svg.dart';
import 'package:vector_math/vector_math.dart' show radians;
import 'package:flutter/material.dart';

class MatchingMainScreen extends StatefulWidget {
  const MatchingMainScreen({super.key});

  @override
  State<MatchingMainScreen> createState() => _MatchingMainScreenState();
}

class _MatchingMainScreenState extends State<MatchingMainScreen> {
  final Random random = Random();

  int getRandomInt(int max) {
    return random.nextInt(max);
  }

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
                SvgPicture.asset('assets/images/characters/01.svg'),
                getRandomWidget(3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getRandomWidget(int count) {
    int max = 4;

    if (count == 0) {
      // Condition 0: Do not show anything
      return Container();
    } else if (count == 4) {
      // Condition 4: Show images in all positions
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(max, (index) {
          return getImageWidget(index);
        }),
      );
    } else {
      // Conditions 1, 2, 3: Show images in random positions
      List<int> selectedPositions = [];

      while (selectedPositions.length < count) {
        int position = getRandomInt(max);

        // Ensure the position is not selected before
        if (!selectedPositions.contains(position)) {
          selectedPositions.add(position);
        }
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(count, (index) {
          return getImageWidget(selectedPositions[index]);
        }),
      );
    }
  }

  Widget getImageWidget(int position) {
    List<double> translations = [
      150 * cos(radians(30)),
      300 * cos(radians(90)),
      200 * cos(radians(250)),
      200 * cos(radians(220)),
    ];

    List<double> verticalTranslations = [
      150 * sin(radians(120)),
      300 * sin(radians(55)),
      200 * sin(radians(270)),
      200 * sin(radians(0)),
    ];
    return Transform(
      transform: Matrix4.identity()
        ..translate(translations[position], verticalTranslations[position]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/characters/char_pudding.png'),
          const SizedBox(
            height: 10,
          ),
          const Text('닉네임')
        ],
      ),
    );
  }
}
