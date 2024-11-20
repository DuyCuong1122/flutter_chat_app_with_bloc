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

class MessageUpdateEvent extends MessageEvent {
  final List<Message> messageList;

  MessageUpdateEvent({required this.messageList});
}

class MessageErrorEvent extends MessageEvent {
  final String errorMessage;

  MessageErrorEvent({required this.errorMessage});
}

class MessageSearchEvent extends MessageEvent {
  final String query;

  MessageSearchEvent({required this.query});
}

class MessageCheckExistEvent extends MessageEvent {
  final User user;

  MessageCheckExistEvent({required this.user});
}