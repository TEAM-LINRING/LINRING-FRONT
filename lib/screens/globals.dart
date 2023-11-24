library globals;

import 'package:flutter/foundation.dart';
import 'package:linring_front_flutter/models/chat_model.dart';
import 'package:linring_front_flutter/models/user_model.dart';
import 'package:linring_front_flutter/screens/tag_add_screen.dart';

ValueNotifier<List<Message>> messages = ValueNotifier([]); // default empty list
ChatRoom currentRoom = ChatRoom();
User opponentUser = User();
