import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:linring_front_flutter/models/chat_model.dart';
import 'package:linring_front_flutter/models/login_info.dart';
import 'package:linring_front_flutter/models/tagset_model.dart';
import 'package:linring_front_flutter/models/user_model.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';
import 'package:http/http.dart' as http;

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
  late Future<List<Message>> _futureMessages;

  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  Future<List<Message>> _loadMessages() async {
    String apiAddress = dotenv.get("API_ADDRESS");
    final url = Uri.parse('$apiAddress/chat/room/');
    final token = widget.loginInfo.access;
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      Pagination pagination = Pagination.fromJson(body);

      return pagination.results!;
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
            opponentTagset = widget.room.tag
          }
        : {
            opponentUser = widget.room.relation2,
            opponentTagset = widget.room.tag2
          };
    _futureMessages = _loadMessages();
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
      appBar: CustomAppBar(title: opponentUser.nickname ?? "LINRING"),
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
            child: FutureBuilder<List<Message>>(
              future: _futureMessages,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  List<Message> messages = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    controller: _scrollController,
                    // itemCount: messages.length,
                    itemBuilder: (context, int index) {
                      // final message = messages[index];
                      // email로 해야하는데 임시로 이름으로 해두었습니다.
                      // bool isMine = message.sender.name == widget.loginInfo.user.id;
                      return Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: const Row(
                          // mainAxisAlignment: isMine
                          // ? MainAxisAlignment.end
                          // : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // _chatBubble(message, isMine),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Text('채팅 데이터가 없습니다.');
                }
              },
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
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              border: Border.all(
                color: const Color(0xffc8aaaa),
              ),
            ),
            child: Row(children: [
              Expanded(
                child: Text(
                  "#${opponentTagset.place} #${opponentTagset.person} #${opponentTagset.method}",
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
                  onPressed: () {},
                  child: const Text(
                    "약속 시간\n 정하기",
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ]),
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
            child: Row(children: [
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
            ]),
          ),
        ),
      ],
    );
  }
}
