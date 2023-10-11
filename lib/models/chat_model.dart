import 'package:linring_front_flutter/models/user_model.dart';

class Room {
  final User relation;
  final User relation2;

  Room({
    required this.relation,
    required this.relation2,
  });
}

class Message {
  final Room room;
  final User sender;
  final User receiver;
  final String message;
  final bool isRead;
  final int type;
  final String? args;

  Message({
    required this.room,
    required this.sender,
    required this.receiver,
    required this.message,
    required this.isRead,
    required this.type,
    this.args,
  });
}

// 테스트용 더미 데이터
final List<Room> allRoom = [
  Room(
    relation: User(
      name: "CJW",
    ),
    relation2: User(
      name: "Hanata",
    ),
  ),
  Room(
    relation: User(
      name: "CJW",
    ),
    relation2: User(
      name: "WJC",
    ),
  ),
];

final List<Message> allMessage = [
  Message(
    room: allRoom[0],
    sender: allRoom[0].relation,
    receiver: allRoom[0].relation2,
    message: "안녕하세요 저는 최지원입니다.",
    isRead: true,
    type: 1,
    args: null,
  ),
  Message(
    room: allRoom[0],
    sender: allRoom[0].relation2,
    receiver: allRoom[0].relation,
    message: "반갑습니다. 저는 하나타입니다.",
    isRead: true,
    type: 1,
    args: null,
  ),
  Message(
    room: allRoom[0],
    sender: allRoom[0].relation,
    receiver: allRoom[0].relation2,
    message: "저희 언제 만나는 걸로 할까요?",
    isRead: true,
    type: 1,
    args: null,
  ),
  Message(
    room: allRoom[0],
    sender: allRoom[0].relation,
    receiver: allRoom[0].relation2,
    message: "내일은 괜찮으신가요?",
    isRead: true,
    type: 1,
    args: null,
  ),
];
