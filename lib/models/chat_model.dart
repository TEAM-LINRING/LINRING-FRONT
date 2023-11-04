import 'package:linring_front_flutter/models/tagset_model.dart';
import 'package:linring_front_flutter/models/user_model.dart';

class ChatRoom {
  final int id;
  final User relation;
  final User relation2;
  final Tagset tag;
  final Tagset tag2;
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
      tag: Tagset.fromJson(json["tagset"]),
      tag2: Tagset.fromJson(json["tagset2"]),
      notice: json["notice"],
      created: DateTime.parse(json["created"]),
      modified: DateTime.parse(json["modified"]),
    );
  }
}

class Pagination {
  final int count;
  final int? next;
  final int? previous;
  final List<Message>? results;

  Pagination({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      count: json["count"],
      next: json["next"],
      previous: json["previous"],
      results: List<Message>.from(
          json["results"].map((messageJson) => Message.fromJson(messageJson))),
    );
  }
}

class Message {
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
      sender: User.fromJson(json["relation"]),
      receiver: User.fromJson(json["relation2"]),
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
