import 'dart:convert';
import 'dart:math';
import 'package:flutter_svg/svg.dart';
import 'package:linring_front_flutter/models/chat_model.dart';
import 'package:linring_front_flutter/models/login_info.dart';
import 'package:linring_front_flutter/models/tagset_model.dart';
import 'package:linring_front_flutter/models/user_model.dart';
import 'package:linring_front_flutter/screens/chat_screen.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MatchingMainScreen extends StatefulWidget {
  final List<Tagset> searchTagset;
  final LoginInfo loginInfo;
  final List<User> searchUser;
  final Tagset myTagset;
  const MatchingMainScreen({
    super.key,
    required this.loginInfo,
    required this.searchTagset,
    required this.searchUser,
    required this.myTagset,
  });

  @override
  State<MatchingMainScreen> createState() => _MatchingMainScreenState();
}

class _MatchingMainScreenState extends State<MatchingMainScreen> {
  final Random random = Random();

  int getRandomInt(int max) {
    return random.nextInt(max);
  }

  Future<ChatRoom> _readChatRoom(int matchingRoomId) async {
    String apiAddress = dotenv.env['API_ADDRESS'] ?? '';
    final url = Uri.parse('$apiAddress/chat/room/$matchingRoomId');
    final token = widget.loginInfo.access;

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      debugPrint((response.statusCode).toString());
      Map<String, dynamic> createRoomData =
          json.decode(utf8.decode(response.bodyBytes));
      ChatRoom readChatRoom = ChatRoom.fromJson(createRoomData);
      return readChatRoom;
    } else {
      throw Exception('Failed to load chat room');
    }
  }

  void _createChatRoom(Tagset matchingTagset) async {
    String apiAddress = dotenv.env['API_ADDRESS'] ?? '';
    final url = Uri.parse('$apiAddress/chat/room/');
    final token = widget.loginInfo.access;

    String body = jsonEncode({
      "relation": widget.loginInfo.user.id,
      "relation2": matchingTagset.owner,
      "tagset": widget.myTagset.id,
      "tagset2": matchingTagset.id
    });

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    if (response.statusCode == 201) {
      debugPrint((response.body).toString());

      Map<String, dynamic> createRoomData =
          json.decode(utf8.decode(response.bodyBytes));
      int matchingRoomId = createRoomData["id"];
      ChatRoom readRoom = await _readChatRoom(matchingRoomId);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatScreen(
                  loginInfo: widget.loginInfo,
                  room: readRoom,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          title: '',
        ),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/matching_main_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
                child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                      'assets/images/characters/0${widget.loginInfo.user.profile}.svg'),
                  const SizedBox(
                    height: 5,
                  ),
                  ...getRandomPositions(widget.searchUser.length),
                ],
              ),
            ))),
      ),
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
                  color: Color.fromARGB(255, 255, 255, 255),
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
                              child: Center(
                                child: SvgPicture.asset(
                                    'assets/images/characters/0${matchingUser.profile}.svg'),
                              ),
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
                                  '${matchingUser.nickname} 님',
                                  style: const TextStyle(fontSize: 19),
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
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
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
                          _createChatRoom(matchingTagset);
                          Navigator.pop(context);
                          // Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => ChatScreen(
//                                       loginInfo: widget.loginInfo,
//                                       r
//                                     )),
//                           );
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

  List<Widget> getRandomPositions(int count) {
    final List<Offset> positions = [
      const Offset(0.7, 0.6), // right ratio, bottom ratio
      const Offset(0.03, 0.4),
      const Offset(0.4, 0.7),
      const Offset(0.55, 0.25),
      const Offset(0.22, 0.15),
      const Offset(0.2, 0.3),
    ];
    int max = positions.length;
    if (count == 0) {
      // Condition 0: Do not show anything
      return <Widget>[];
    } else {
      // Show images in random positions
      List<int> selectedPositions = [];

      while (selectedPositions.length < count) {
        int position = getRandomInt(max);
        // Ensure the position is not selected before
        if (!selectedPositions.contains(position)) {
          selectedPositions.add(position);
        }
      }
      return List.generate(count, (index) {
        print(selectedPositions);
        return getImageWidget(index, positions[selectedPositions[index]]);
      });
    }
  }

  Widget getImageWidget(int index, Offset offset) {
    final screenSize = MediaQuery.of(context).size;
    final right = screenSize.width * offset.dx;
    final bottom = screenSize.height * offset.dy;
    return Positioned(
      bottom: bottom,
      right: right,
      child: GestureDetector(
        onTap: () {
          debugPrint('온탭 !!!');
          _showSearchDetailModal(
              widget.searchUser[index], widget.searchTagset[index]);
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
                'assets/images/characters/0${widget.searchUser[index].profile}.svg'),
            const SizedBox(
              height: 10,
            ),
            Text('${widget.searchUser[index].nickname}')
          ],
        ),
      ),
    );
  }
}
