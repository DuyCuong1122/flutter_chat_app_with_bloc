import '../../database/models/message.dart';

class MessageChat{}

class MessageChatInitial extends MessageChat{}

class MessageChatLoading extends MessageChat{}

class MessageChatSuccess extends MessageChat{
  final List<Message> messagesList;
  MessageChatSuccess({required this.messagesList});
}

class MessageCreateSuccess extends MessageChat{}

