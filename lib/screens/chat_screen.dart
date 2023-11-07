import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:linring_front_flutter/models/chat_model.dart';
import 'package:linring_front_flutter/models/login_info.dart';
import 'package:linring_front_flutter/models/tagset_model.dart';
import 'package:linring_front_flutter/models/user_model.dart';
import 'package:linring_front_flutter/screens/report_screen.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';
import 'package:http/http.dart' as http;
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final LoginInfo loginInfo;
  final ChatRoom room;
  const ChatScreen({required this.loginInfo, required this.room, super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late User opponentUser;
  late Tagset opponentTagset;
  List<Message> _messages = [];

  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  bool afterMeeting = true;

  Future<void> _loadMessages() async {
    String apiAddress = dotenv.get("API_ADDRESS");
    final url = Uri.parse('$apiAddress/chat/message/');
    final token = widget.loginInfo.access;
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      _messages = (body['results'] as List<dynamic>)
          .map<Message>((e) => Message.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load messages.');
    }
  }

  @override
  void initState() {
    super.initState();
    (widget.loginInfo.user.id == widget.room.relation2.id)
        ? {
            opponentUser = widget.room.relation,
            opponentTagset = widget.room.tag,
          }
        : {
            opponentUser = widget.room.relation2,
            opponentTagset = widget.room.tag2,
          };
    _loadMessages().then((value) => setState(() {}));
  }

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    // 서버에 채팅 메세지 전송 추가
    _controller.clear();
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: opponentUser.nickname ?? "LINRING",
        suffix: PopupMenuButton<int>(
          onSelected: (int result) {
            // 팝업 메뉴 항목 선택 시 실행할 코드를 여기에 작성합니다.
            if (result == 1) {
              // 팝업 메뉴 항목 1을 선택한 경우에 실행할 코드
            } else if (result == 2) {
              // 팝업 메뉴 항목 2를 선택한 경우에 실행할 코드
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReportScreen(
                          loginInfo: widget.loginInfo, room: widget.room)));
            }
          },
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.add),
                    Text("프로필 확인하기"),
                  ],
                ),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    Text("신고하기"),
                  ],
                ),
              ),
            ];
          },
          child: const Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: const Color(0xfffff6f4),
      body: Column(
        children: [
          _matchInfo(),
          _chatContainer(),
          _chatInput(),
        ],
      ),
    );
  }

  Widget _chatBubble(Message message, bool isMine) {
    return Container(
      decoration: BoxDecoration(
        color: isMine ? const Color(0xfff3c2b5) : Colors.white,
        border: Border.all(
          width: 2.0,
          color: const Color(0xfff3c2b5),
        ),
        borderRadius: isMine
            ? const BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              )
            : const BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(message.message),
      ),
    );
  }

  Widget _timeChat() {
    DateTime datetime = DateTime.parse("2023-11-20 18:26:00.000");
    final promise = DateFormat('M월 d일 (E) H시 m분', 'ko_KR').format(datetime);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xffc8aaaa)),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            const TextSpan(
              text: '알림',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: ' $promise로 약속 시간을 정했어요.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _chatContainer() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // 가상 키보드 unfocusing
          },
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xffc8aaaa)),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                          text: '알림',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' ${widget.room.tag.place}에서 ${widget.room.tag.person}랑 ${widget.room.tag.method}하기를 선택한 ${widget.room.relation.nickname}님이 ${widget.room.tag.place}에서 ${widget.room.tag2.person}랑 ${widget.room.tag2.method}하기를 선택한 ${widget.room.relation2.nickname}님에게 채팅을 걸었습니다.',
                        ),
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  controller: _scrollController,
                  itemCount: _messages.length,
                  itemBuilder: (context, int index) {
                    final message = _messages[index];
                    bool isMine = message.sender.id == widget.loginInfo.user.id;
                    return Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: isMine
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [_chatBubble(message, isMine)],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 매칭 정보(태그 정보, 약속 시간 표시)
  Widget _matchInfo() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color(0xffc8aaaa),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "#${opponentTagset.place}  #${opponentTagset.person}  #${opponentTagset.method}",
                    textAlign: TextAlign.center,
                  ),
                ),
                const VerticalDivider(
                  indent: 10,
                  endIndent: 10,
                  thickness: 1,
                  color: Color(0xffc8aaaa),
                ),
                SizedBox(
                  width: 90,
                  child: TextButton(
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.all<TextStyle?>(
                        const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (afterMeeting) {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ReportScreen(
                        //             loginInfo: widget.loginInfo,
                        //             room: widget.room)));
                        showModalBottomSheet<void>(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          builder: (BuildContext context) {
                            return Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                height: 270,
                                child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const SizedBox(
                                              width: 48,
                                              height: 20,
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.close_rounded,
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Text(
                                            '여섯글자이름님과 잘 만나고 오셨나요?',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Text(
                                            '알고리즘 성능 향상을 위해',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Text(
                                            '매너평가를 남겨주세요!',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: CustomOutlinedButton(
                                            label: '상대방 매너평가 남기기',
                                            backgroundColor:
                                                const Color(0xFFFEC2B5),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              showModalBottomSheet(
                                                  context: context,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                  ),
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                10, 10, 10, 10),
                                                        height: 330,
                                                        child: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      const SizedBox(
                                                                        width:
                                                                            48,
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      const Text(
                                                                        '여섯글자이름님과의 만남 매너 평가',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                      IconButton(
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .close_rounded,
                                                                        ),
                                                                        onPressed:
                                                                            () =>
                                                                                Navigator.pop(context),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  RatingBar(
                                                                    initialRating:
                                                                        0,
                                                                    direction: Axis
                                                                        .horizontal,
                                                                    allowHalfRating:
                                                                        false,
                                                                    itemCount:
                                                                        5,
                                                                    ratingWidget:
                                                                        RatingWidget(
                                                                      full: image(
                                                                          'assets/images/fullStar.png'),
                                                                      half: image(
                                                                          'assets/images/fullStar.png'),
                                                                      empty: image(
                                                                          'assets/images/emptyStar.png'),
                                                                    ),
                                                                    itemPadding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            4.0),
                                                                    onRatingUpdate:
                                                                        (rating) {
                                                                      print(
                                                                          rating);
                                                                    },
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 25,
                                                                  ),
                                                                  const Text(
                                                                    '별점을 남겨주세요.',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  const Text(
                                                                    '상대방은 평가 결과를 알 수 없으니 안심하세요!',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 30,
                                                                  ),
                                                                  Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          10,
                                                                          0),
                                                                      child: CustomOutlinedButton(
                                                                          backgroundColor: const Color(
                                                                              0xFFFEC2B5),
                                                                          label:
                                                                              '상대방 매너평가 남기기',
                                                                          onPressed:
                                                                              () {}))
                                                                ])));
                                                  });
                                            },
                                          ),
                                        )
                                      ],
                                    )));
                          },
                        );
                      } else {
                        final selectedDate = await showOmniDateTimePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                          is24HourMode: false,
                          isShowSeconds: false,
                          minutesInterval: 1,
                          secondsInterval: 1,
                          isForce2Digits: true,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        );
                      }
                    },
                    child: Text(
                      afterMeeting ? "매너평가하기" : "약속 시간\n 정하기",
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  // 채팅 입력창
  Widget _chatInput() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 60,
            margin: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color(0xffc8aaaa),
                style: BorderStyle.solid,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        // _enteredMessage = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  highlightColor: Colors.transparent, // 물결 효과 제거
                  splashColor: Colors.transparent, // 물결 효과 제거
                  onPressed: () {},
                  //_enteredMessage.trim().isEmpty ? null : _sendMessage,
                  icon: Image.asset(
                    "assets/icons/send_button.png",
                    width: 20,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
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
