import 'package:flutter/material.dart';
import 'package:linring_front_flutter/models/chat_model.dart';
import 'package:linring_front_flutter/models/login_info.dart';

class ChatRoomScreen extends StatelessWidget {
  final LoginInfo loginInfo;
  const ChatRoomScreen({required this.loginInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffff6f4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "대화 목록",
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: allRoom.length,
        itemBuilder: (context, int index) {
          Room room = allRoom[index];
          return _chatRoom(room, context);
        },
      ),
    );
  }

  Widget _chatRoom(Room room, BuildContext context) {
    return InkWell(
      onTap: () => {Navigator.pushNamed(context, '/chat')},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: const Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xffd9d9d9),
              radius: 28,
            ),
            SizedBox(
              width: 14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hanata"),
                Text("#태그 #태그 #태그"),
                Text("최근 대화 내용"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
