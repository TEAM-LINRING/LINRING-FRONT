import 'dart:convert';
import 'dart:math';
import 'package:flutter_svg/svg.dart';
import 'package:linring_front_flutter/models/chat_model.dart';
import 'package:linring_front_flutter/models/login_info.dart';
import 'package:linring_front_flutter/models/tagset_model.dart';
import 'package:linring_front_flutter/models/user_model.dart';
import 'package:linring_front_flutter/screens/chat_screen.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';
import 'package:vector_math/vector_math.dart' show radians;
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
              SvgPicture.asset(
                  'assets/images/characters/0${widget.loginInfo.user.profile}.svg'),
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
                        SvgPicture.asset(
                            'assets/images/characters/0${widget.searchUser[0].profile}.svg'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('${widget.searchUser[0].nickname}')
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
                    _showSearchDetailModal(
                        widget.searchUser[1], widget.searchTagset[1]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(130.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                            'assets/images/characters/0${widget.searchUser[1].profile}.svg'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('${widget.searchUser[1].nickname}')
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
                    _showSearchDetailModal(
                        widget.searchUser[2], widget.searchTagset[2]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(180.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                            'assets/images/characters/0${widget.searchUser[2].profile}.svg'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('${widget.searchUser[2].nickname}')
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
                    _showSearchDetailModal(
                        widget.searchUser[3], widget.searchTagset[3]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(100.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                            'assets/images/characters/0${widget.searchUser[3].profile}.svg'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('${widget.searchUser[3].nickname}')
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
}
