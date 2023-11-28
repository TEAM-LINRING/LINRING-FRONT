import 'package:linring_front_flutter/models/tagset_model.dart';
import 'package:linring_front_flutter/models/user_model.dart';

class ChatRoom {
  final int? id;
  final User? relation;
  final User? relation2;
  final Tagset? tag;
  final Tagset? tag2;
  final int? notice;
  Message? latestMessage;
  DateTime? reservationTime;
  final DateTime? created;
  final DateTime? modified;

  ChatRoom({
    this.id,
    this.relation,
    this.relation2,
    this.tag,
    this.tag2,
    this.notice,
    this.latestMessage,
    this.reservationTime,
    this.created,
    this.modified,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json["id"],
      relation: User.fromJson(json["relation"]),
      relation2: User.fromJson(json["relation2"]),
      tag: Tagset.fromJson(json["tagset"]),
      tag2: Tagset.fromJson(json["tagset2"]),
      notice: json["notice"],
      latestMessage: (json["latest_message"] != null)
          ? Message.fromJson(json["latest_message"])
          : null,
      reservationTime: (json["reservation_time"] != null)
          ? DateTime.parse(json["reservation_time"])
          : null,
      created: DateTime.parse(json["created"]),
      modified: DateTime.parse(json["modified"]),
    );
  }
}

class Message {
  final int id;
  final User sender;
  final User receiver;
  final String created;
  final String modified;
  final String message;
  final bool isRead;
  final int type;
  final String? args;
  final int room;

  Message({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.created,
    required this.modified,
    required this.message,
    required this.isRead,
    required this.type,
    required this.args,
    required this.room,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json["id"],
      sender: User.fromJson(json["sender"]),
      receiver: User.fromJson(json["receiver"]),
      created: json["created"],
      modified: json["modified"],
      message: json["message"],
      isRead: json["is_read"],
      type: json["type"],
      args: json["args"],
      room: json["room"],
    );
  }
}
