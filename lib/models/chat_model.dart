import 'package:linring_front_flutter/models/tagset_model.dart';
import 'package:linring_front_flutter/models/user_model.dart';

class ChatRoom {
  final int id;
  final User relation;
  final User relation2;
  final tagset tag;
  final tagset tag2;
  final int? notice;
  final DateTime created;
  final DateTime modified;

  ChatRoom({
    required this.id,
    required this.relation,
    required this.relation2,
    required this.tag,
    required this.tag2,
    required this.notice,
    required this.created,
    required this.modified,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json["id"],
      relation: User.fromJson(json["relation"]),
      relation2: User.fromJson(json["relation2"]),
      tag: tagset.fromJson(json["tagset"]),
      tag2: tagset.fromJson(json["tagset2"]),
      notice: json["notice"] ?? 0,
      created: DateTime.parse(json["created"]),
      modified: DateTime.parse(json["modified"]),
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
