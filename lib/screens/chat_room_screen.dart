import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:linring_front_flutter/models/chat_model.dart';
import 'package:linring_front_flutter/models/login_info.dart';
import 'package:linring_front_flutter/models/tagset_model.dart';
import 'package:linring_front_flutter/models/user_model.dart';
import 'package:linring_front_flutter/screens/chat_screen.dart';

class ChatRoomScreen extends StatefulWidget {
  final LoginInfo loginInfo;
  const ChatRoomScreen({required this.loginInfo, super.key});

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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "채팅 목록",
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
            print(rooms?.length);
            if (rooms!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/characters/char_404.svg',
                      width: 130,
                    ),
                    const SizedBox(height: 20), // 이미지와 텍스트 간격 조절
                    const Text(
                      '아직 채팅방이 없어요. \n 친구를 검색해서 말을 걸어 볼까요?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (context, int index) {
                  ChatRoom room = rooms[index];
                  return _chatRoom(room, context);
                },
              );
            }
          }
        },
      ),
    );
  }

  Widget _chatRoom(ChatRoom room, BuildContext context) {
    User opponentUser;
    Tagset opponentTagset;

    (widget.loginInfo.user.id == room.relation2.id)
        ? {opponentUser = room.relation, opponentTagset = room.tag}
        : {opponentUser = room.relation2, opponentTagset = room.tag2};

    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              loginInfo: widget.loginInfo,
              room: room,
            ),
          ),
        ),
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: Color(0xffc8aaaa),
          ),
        )),
        child: Row(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: const Color(0xffc8c8c8), width: 0.7)),
              child: Center(
                child: SvgPicture.asset(
                    'assets/images/characters/0${opponentUser.profile}.svg',
                    width: 49),
              ),
            ),
            const SizedBox(
              width: 14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  opponentUser.nickname!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff191919),
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  "최근 대화 내용",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff191919),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 7),
                Text(
                  "#${opponentTagset.place} #${opponentTagset.person} #${opponentTagset.method}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color(0xff92867c),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
