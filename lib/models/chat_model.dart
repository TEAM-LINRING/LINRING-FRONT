import 'package:linring_front_flutter/models/tagset_model.dart';
import 'package:linring_front_flutter/models/user_model.dart';

class ChatRoom {
  final User relation;
  final User relation2;
  final tagset tag;
  final tagset tag2;

  ChatRoom({
    required this.relation,
    required this.relation2,
    required this.tag,
    required this.tag2,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      relation: json["relation"],
      relation2: json["relation2"],
      tag: json["tagset"],
      tag2: json["tagset2"],
    );
  }
}

class Message {
  final ChatRoom room;
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
