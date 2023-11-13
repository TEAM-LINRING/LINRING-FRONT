import 'dart:math';
import 'package:flutter_svg/svg.dart';
import 'package:linring_front_flutter/models/login_info.dart';
import 'package:linring_front_flutter/models/tagset_model.dart';
import 'package:linring_front_flutter/models/user_model.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';
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
          child: Center(
              child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset('assets/images/characters/01.svg'),
              const SizedBox(
                height: 5,
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(150 * cos(radians(30)), 150 * sin(radians(120))),
                child: GestureDetector(
                  onTap: () {
                    debugPrint('0번 온탭 !!!');
                    _showSearchDetailModal(
                        widget.searchUser[0], widget.searchTagset[0]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(100.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/images/characters/01.svg'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('0${widget.searchUser[0].nickname}')
                      ],
                    ),
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(200 * cos(radians(220)), 200 * sin(radians(0))),
                child: GestureDetector(
                  onTap: () {
                    debugPrint('1번 온탭 !!!');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(130.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/images/characters/01.svg'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('1${widget.searchUser[1].nickname}')
                      ],
                    ),
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(300 * cos(radians(90)), 300 * sin(radians(55))),
                child: GestureDetector(
                  onTap: () {
                    debugPrint('2번 온탭 !!!');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(180.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/images/characters/01.svg'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('2${widget.searchUser[2].nickname}')
                      ],
                    ),
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(200 * cos(radians(250)), 200 * sin(radians(270))),
                child: GestureDetector(
                  onTap: () {
                    debugPrint('3번 온탭 !!!');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(100.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/images/characters/01.svg'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('3${widget.searchUser[3].nickname}')
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ))),
    );
  }

  final List<String> remark = [
    '유학생',
    '전과생',
    '편입생',
    '외국인',
    '교환학생',
    '복수전공생',
    '부전공생',
    '휴학생',
  ];
  String getStatesByNumbers(List<int> numbers) {
    List<String> selectedStates = numbers
        .where((number) => number >= 1 && number <= remark.length)
        .map((number) => remark[number - 1])
        .toList();

    return selectedStates.join(', ');
  }

  void _showSearchDetailModal(User matchingUser, Tagset matchingTagset) {
    int? birth = matchingUser.birth;
    int? age = 2024 - birth!;
    List<int>? selectedNumbers = matchingUser.significant;
    String selectedStatesString = getStatesByNumbers(selectedNumbers!);
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      builder: (BuildContext context) {
        return Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            height: 300,
            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 48,
                          height: 20,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close_rounded,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: const Color(0xffc8c8c8),
                                      width: 0.7)),
                              child: const Center(
                                  child: Image(
                                image:
                                    AssetImage('assets/images/avartar_1.png'),
                                width: 100,
                              )),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 10, 0),
                                child: Text(
                                  '${matchingUser.nickname}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 10, 0),
                                child: Text(
                                  '${matchingUser.department} ${matchingUser.studentNumber}학번',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 10, 0),
                                child: Text(
                                  '$age살 ${matchingUser.gender}자 $selectedStatesString',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: Text(
                        '"${matchingTagset.introduction}"',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: CustomOutlinedButton(
                        isActive: true,
                        label: '이 친구와 채팅하기',
                        backgroundColor: const Color(0xFFFEC2B5),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                )));
      },
    );
  }

  Widget image(String asset) {
    return Image.asset(
      asset,
      height: 25,
      width: 25,
    );
  }
}
