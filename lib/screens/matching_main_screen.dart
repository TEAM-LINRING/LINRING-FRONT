import 'dart:math';
import 'package:flutter_svg/svg.dart';
import 'package:linring_front_flutter/models/login_info.dart';
import 'package:linring_front_flutter/models/tagset_model.dart';
import 'package:linring_front_flutter/models/user_model.dart';
import 'package:vector_math/vector_math.dart' show radians;
import 'package:flutter/material.dart';

class MatchingMainScreen extends StatefulWidget {
  final List<Tagset> searchTagset;
  final LoginInfo loginInfo;
  final List<User> searchUser;
  const MatchingMainScreen(
      {super.key,
      required this.loginInfo,
      required this.searchTagset,
      required this.searchUser});

  @override
  State<MatchingMainScreen> createState() => _MatchingMainScreenState();
}

class _MatchingMainScreenState extends State<MatchingMainScreen> {
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
                getFixedWidget([0, 1, 2, 3]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getFixedWidget(List<int> positions) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: positions.map((position) {
        return getImageWidget(position);
      }).toList(),
    );
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

    // positions 리스트에 있는 각 인덱스에 해당하는 위치 정보 가져오기
    double translation = translations[position];
    double verticalTranslation = verticalTranslations[position];
    // 해당 position에 대응하는 Tagset을 가져오기
    return Transform(
      transform: Matrix4.identity()
        ..translate(translation, verticalTranslation),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/characters/char_pudding.png'),
          const SizedBox(
            height: 10,
          ),
          Text('${widget.searchUser[position].nickname}'),
        ],
      ),
    );
  }
}
