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
  final String args;

  Message({
    required this.room,
    required this.sender,
    required this.receiver,
    required this.message,
    required this.isRead,
    required this.type,
    required this.args,
  });
}