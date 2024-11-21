import 'package:chat_app/database/models/message_content.dart';

import '../../database/models/message.dart';

class MessageChatEvent {}

class MessageSendEvent extends MessageChatEvent {
  final MessageContent messageContent;
  final Message message;
  MessageSendEvent({required this.messageContent, required this.message});
}

class MessageGetAllChatEvent extends MessageChatEvent {
  final Message message;
  MessageGetAllChatEvent({required this.message});
}

class MessagesUpdatedEvent extends MessageChatEvent {
  final List<MessageContent> messagesList;
  MessagesUpdatedEvent({required this.messagesList});
}

class MessageChatErrorEvent extends MessageChatEvent {
  final String errorMessage;
  MessageChatErrorEvent({required this.errorMessage});
}