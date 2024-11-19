import 'package:chat_app/database/models/message.dart';

import '../../database/models/user.dart';

class MessageEvent {}


class MessageGetAllEvent extends MessageEvent {
}

class MessageReadEvent extends MessageEvent {
  final Message message;

  MessageReadEvent({required this.message});
}

class MessageCreateEvent extends MessageEvent {
  final User toUser;

  MessageCreateEvent({required this.toUser});
}