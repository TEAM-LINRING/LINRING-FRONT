import 'package:flutter/material.dart';
import 'package:linring_front_flutter/models/chat_model.dart';
import 'package:linring_front_flutter/models/user_model.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    // required this.user,
  });

  // final User user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

// Dummy Data Start
List tag = [
  '자율주행스튜디오',
  ['다른 과', '선배'],
  '친구하기'
];

String username = 'Hanata';
String logginedUser = 'CJW';

// Dummy Data End

class _ChatScreenState extends State<ChatScreen> {
  var _enteredMessage = '';
  final _controller = TextEditingController();
  void _sendMessage() {
    FocusScope.of(context).unfocus();
    // 서버에 채팅 메세지 전송하는 것으로 변경 예정
    allMessage.add(
      Message(
        room: Room(
          relation: User(name: 'CJW'),
          relation2: User(name: 'Hanata'),
        ),
        sender: User(name: 'CJW'),
        receiver: User(name: 'Hanata'),
        message: _enteredMessage,
        isRead: true,
        type: 1,
      ),
    );
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(title: username),
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
        child: ListView.builder(
          itemCount: allMessage.length,
          itemBuilder: (context, int index) {
            final message = allMessage[index];
            // email로 해야하는데 임시로 이름으로 해두었습니다.
            bool isMine = message.sender.name == logginedUser;
            return Container(
              margin: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment:
                    isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _chatBubble(message, isMine),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // 매칭 정보(태그 정보, 약속 시간 표시)
  Widget _matchInfo() {
    // 태그 정보 --> 해시 태그 Format으로 변경
    String formattedTag = '';
    for (var item in tag) {
      if (item is String) {
        formattedTag += '#$item ';
      } else if (item is List<String>) {
        formattedTag += '#${item.join('_')} ';
      }
    }
    formattedTag = formattedTag.trim();

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
                  formattedTag,
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
                      _enteredMessage = value;
                    });
                  },
                ),
              ),
              IconButton(
                highlightColor: Colors.transparent, // 물결 효과 제거
                splashColor: Colors.transparent, // 물결 효과 제거
                onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
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
