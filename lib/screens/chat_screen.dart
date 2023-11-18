import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
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
  String _enteredMessage = "";
  String ratingScore = "0";
  DateTime? promiseDate;
  late DateTime twoHoursLater;
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  bool afterMeeting = false;
  bool afterPromise = false;
  bool endMeeting = false;
  bool buttonIsActive = false;

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

      // 기존 채팅 불러오기
      _messages = (body as List<dynamic>)
          .map<Message>((e) => Message.fromJson(e))
          .toList();

      // 입장 알림 메세지 리스트 맨 앞에 추가
      _messages.insert(
          0,
          Message(
            id: 0,
            sender: widget.loginInfo.user,
            receiver: opponentUser,
            created: "",
            modified: "",
            message:
                ' ${widget.room.tag.place}에서 ${widget.room.tag.person}랑 ${widget.room.tag.method}${widget.room.tag.method == "카페" ? "가기" : "하기"}를 선택한 ${widget.room.relation.nickname}님이 ${widget.room.tag.place}에서 ${widget.room.tag2.person}랑 ${widget.room.tag2.method}${widget.room.tag2.method == "카페" ? "가기" : "하기"}를 선택한 ${widget.room.relation2.nickname}님에게 채팅을 걸었습니다.',
            isRead: true,
            type: 0,
            args: null,
            room: widget.room.id,
          ));
      // 역순으로 재배치
      _messages = _messages.reversed.toList();
    } else {
      throw Exception('Failed to load messages.');
    }
  }

  void _createRating() async {
    String apiAddress = dotenv.env['API_ADDRESS'] ?? '';
    final url = Uri.parse('$apiAddress/accounts/rating/update/');
    final token = widget.loginInfo.access;

    String body = jsonEncode({"user": opponentUser.id, "rating": ratingScore});

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    debugPrint((response.statusCode).toString());
    debugPrint(body);
    if (response.statusCode == 200) {
      if (!mounted) return;
      afterMeeting = false;
      Navigator.pop(context);
    }
  }

  void _patchReservationTime() async {
    print('_patchReservationTime이 실행됨');
    String apiAddress = dotenv.get("API_ADDRESS");
    String? isoFormattedString;
    final url = Uri.parse('$apiAddress/chat/room/${widget.room.id}/');
    final token = widget.loginInfo.access;
    if (promiseDate == null) {
      print('promiseDate가 null임 !!!');
      isoFormattedString = null;
    } else {
      print('null이 아님 ..');
      twoHoursLater = promiseDate!.add(const Duration(hours: 2));
      isoFormattedString = formatISOTime(promiseDate!);
    }
    final body = jsonEncode({
      "tagset": widget.room.tag.id,
      "tagset2": widget.room.tag2.id,
      "reservation_time": isoFormattedString,
    });
    print(body);
    await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );

    print('아직 patch안에 있음');
    print(promiseDate);
    print('${widget.room.reservationTime}');
  }

  String formatISOTime(DateTime date) {
    var duration = date.timeZoneOffset;
    if (duration.isNegative) {
      return ("${DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").format(date)}-${duration.inHours.toString().padLeft(2, '0')}${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
    } else {
      return ("${DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").format(date)}+${duration.inHours.toString().padLeft(2, '0')}${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
    }
  }

  @override
  void initState() {
    print('initState');
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
    if (widget.room.reservationTime != null) {
      print('initState 중 if문 in');
      afterPromise = true;
      promiseDate = widget.room.reservationTime;
      print('print PromiseDate: $promiseDate');
      twoHoursLater = promiseDate!.add(const Duration(hours: 2));
      print('print twoHoursLater: $twoHoursLater');

      if (twoHoursLater.isAfter(promiseDate!)) {
        afterMeeting = true;
      }
    } else {
      afterMeeting = false;
      afterPromise = false;
    }
    _loadMessages().then((value) => setState(() {}));
  }

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    // 서버에 채팅 메세지 전송 추가
    String apiAddress = dotenv.env['API_ADDRESS'] ?? '';
    final url = Uri.parse('$apiAddress/chat/message/');
    final token = widget.loginInfo.access;

    String body = jsonEncode({
      "message": _enteredMessage,
      "is_read": false,
      "type": 1,
      "args": null,
      "room": widget.room.id,
      "sender": widget.loginInfo.user.id,
      "receiver": opponentUser.id,
    });

    await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );

    setState(() {
      // 로컬 리스트에 임시 저장
      _messages.insert(
          0,
          Message(
            id: 0,
            sender: widget.loginInfo.user,
            receiver: opponentUser,
            created: "",
            modified: "",
            message: _enteredMessage,
            isRead: true,
            type: 1,
            args: null,
            room: widget.room.id,
          ));
    });

    _controller.clear();
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    _enteredMessage = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CustomAppBar(
          loginInfo: widget.loginInfo,
          title: opponentUser.nickname ?? "LINRING",
          suffix: PopupMenuButton<int>(
            onSelected: (int result) {
              if (result == 1) {
                _showProfileModal(context);
              } else if (result == 2) {
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

  // chat type 0
  Widget _chatEntry(Message message) {
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
              text: message.message,
            ),
          ],
        ),
      ),
    );
  }

  // chat type 1
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
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemCount: _messages.length,
                    itemBuilder: (context, int index) {
                      final message = _messages[index];
                      bool isMine =
                          message.sender.id == widget.loginInfo.user.id;

                      Widget chatWidget;

                      if (message.type == 0) {
                        chatWidget = Expanded(child: _chatEntry(message));
                      } else if (message.type == 1) {
                        chatWidget = _chatBubble(message, isMine);
                      } else {
                        chatWidget = Container();
                      }

                      return Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: isMine
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [chatWidget],
                        ),
                      );
                    },
                  ),
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
    int? birth = opponentUser.birth;
    int? year = 2024 - birth!;
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color(0xffc8aaaa),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _showProfileModal(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: const Color(0xffc8c8c8), width: 0.7)),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/characters/0${opponentUser.profile}.svg',
                          width: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "#${opponentTagset.place}  #${opponentTagset.person}  #${opponentTagset.method}${opponentTagset.method == "카페" ? "가기" : "하기"}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "${opponentUser.department}  ${opponentUser.studentNumber}학번  $year살  ${opponentUser.gender}자",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
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
                      if (endMeeting) {
                      } else if (afterMeeting) {
                        _showRatingModal(context);
                      } else {
                        final selectedDate = await showOmniDateTimePicker(
                          context: context,
                          initialDate: widget.room.reservationTime,
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
                        promiseDate = selectedDate!;
                        print('primiseDate를 selectedDate에 넣었음');
                        afterPromise = true;
                        widget.room.reservationTime = promiseDate!;
                        updateMatchInfo();
                        _patchReservationTime();
                        print('patch 호출 후 print');
                        print(promiseDate);
                      }
                    },
                    child: Text(
                      endMeeting
                          ? "만남 완료"
                          : afterMeeting
                              ? "매너평가하기"
                              : afterPromise
                                  ? "${promiseDate!.year}-${promiseDate!.month}-${promiseDate!.day}\n${promiseDate!.hour} : ${promiseDate!.minute}"
                                  : "약속 시간\n 정하기",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 13, color: Colors.black),
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

  void updateMatchInfo() {
    setState(() {
      //_matchInfo 함수를 다시 호출해서 화면 갱신
    });
  }

  // bool _buttonIsActive() {
  //   if (ratingScore.isNotEmpty) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

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
                    onTap: () {
                      //scrollAnimate();
                    },
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _enteredMessage = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  highlightColor: Colors.transparent, // 물결 효과 제거
                  splashColor: Colors.transparent, // 물결 효과 제거

                  onPressed: () {
                    _enteredMessage.trim().isEmpty ? null : _sendMessage();
                  },
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

  void _showRatingModal(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      builder: (BuildContext context) {
        return Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            height: 270,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        '${opponentUser.nickname}님과 잘 만나고 오셨나요?',
                        style: const TextStyle(fontSize: 19),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        '알고리즘 성능 향상을 위해',
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        '매너평가를 남겨주세요!',
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: CustomOutlinedButton(
                        label: '매너평가 남기기',
                        backgroundColor: const Color(0xFFFEC2B5),
                        isActive: true,
                        onPressed: () {
                          Navigator.pop(context);
                          showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              builder: (BuildContext context) {
                                return Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    height: 330,
                                    child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Column(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(
                                                width: 48,
                                                height: 20,
                                              ),
                                              Text(
                                                "${opponentUser.nickname}님과의 만남 매너 평가",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          RatingBar(
                                            initialRating: 0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: false,
                                            itemCount: 5,
                                            ratingWidget: RatingWidget(
                                              full: image(
                                                  'assets/images/fullStar.png'),
                                              half: image(
                                                  'assets/images/fullStar.png'),
                                              empty: image(
                                                  'assets/images/empty_Star.png'),
                                            ),
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                            onRatingUpdate: (rating) {
                                              setState(() {
                                                ratingScore =
                                                    (rating.toInt()).toString();
                                                print(ratingScore);
                                                // buttonIsActive =
                                                //     _buttonIsActive();
                                              });
                                            },
                                          ),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          const Text(
                                            '매너평가 별점을 남겨주세요.',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            '상대방은 점수를 알 수 없으니 안심하세요!',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: CustomOutlinedButton(
                                              isActive: true,
                                              //buttonIsActive,
                                              backgroundColor:
                                                  const Color(0xFFFEC2B5),
                                              label: '매너평가 남기기',
                                              onPressed: () {
                                                _createRating();
                                                afterPromise = false;
                                                afterMeeting = false;
                                                endMeeting = true;
                                                widget.room.reservationTime =
                                                    null;
                                                promiseDate = null;
                                                _patchReservationTime();
                                                print('null로 패치된거야??');
                                              },
                                            ),
                                          )
                                        ])));
                              });
                        },
                      ),
                    )
                  ],
                )));
      },
    );
  }

  void _showProfileModal(BuildContext context) {
    debugPrint(opponentUser.profile.toString());
    int? birth = opponentUser.birth;
    int? year = 2024 - birth!;
    List<int>? selectedNumbers = opponentUser.significant;
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
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                                  color: const Color(0xffc8c8c8), width: 0.7)),
                          child: Center(
                            child: SvgPicture.asset(
                                'assets/images/characters/0${opponentUser.profile}.svg'),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Text(
                              '${opponentUser.nickname}님',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: '${opponentUser.department} ',
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                              TextSpan(
                                text: '${opponentUser.studentNumber}학번',
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                            ])),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: '$year살 ',
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                              TextSpan(
                                text: '${opponentUser.gender}자 ',
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                              TextSpan(
                                text: selectedStatesString,
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                            ])),
                          ),
                          const SizedBox(
                            height: 2,
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
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    '"${opponentTagset.introduction}"',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: CustomOutlinedButton(
                    isActive: true,
                    label: '프로필 닫기',
                    backgroundColor: const Color(0xFFFEC2B5),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
