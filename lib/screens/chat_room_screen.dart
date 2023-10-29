import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:linring_front_flutter/models/chat_model.dart';
import 'package:linring_front_flutter/models/login_info.dart';

class ChatRoomScreen extends StatefulWidget {
  final LoginInfo loginInfo;
  const ChatRoomScreen({required this.loginInfo, Key? key}) : super(key: key);

  @override
  State createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  late Future<List<ChatRoom>> _futureRooms;

  @override
  void initState() {
    super.initState();
    _futureRooms = _loadChatRooms();
  }

  Future<List<ChatRoom>> _loadChatRooms() async {
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
      final List parsedList = json.decode(utf8.decode(response.bodyBytes));
      List<ChatRoom> rooms =
          parsedList.map((val) => ChatRoom.fromJson(val)).toList();
      return rooms;
    } else {
      throw Exception('Failed to load chat rooms.');
    }
  }

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
      body: FutureBuilder(
        future: _futureRooms,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("에러 ${snapshot.error}");
          } else if (!snapshot.hasData) {
            return const Text("데이터 없음.");
          } else {
            List<ChatRoom>? rooms = snapshot.data;
            return ListView.builder(
              itemCount: rooms?.length,
              itemBuilder: (context, int index) {
                ChatRoom room = rooms![index];
                return _chatRoom(room, context);
              },
            );
          }
        },
      ),
    );
  }

  Widget _chatRoom(ChatRoom room, BuildContext context) {
    return InkWell(
      onTap: () => {Navigator.pushNamed(context, '/chat')},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xffd9d9d9),
              radius: 28,
            ),
            const SizedBox(
              width: 14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(room.relation2.nickname ?? ""),
                Text(
                    "#${room.tag2.place} #${room.tag2.owner} #${room.tag2.method}"),
                const Text("최근 대화 내용"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
