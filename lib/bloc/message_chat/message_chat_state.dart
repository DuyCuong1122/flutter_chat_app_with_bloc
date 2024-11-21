import 'package:chat_app/database/models/message_content.dart';

class MessageChatState{}

class MessageChatInitialState extends MessageChatState{}

class MessageChatLoadingState extends MessageChatState{}

class MessageChatSuccessState extends MessageChatState{
  final List<MessageContent> messagesList;
  MessageChatSuccessState({required this.messagesList});
}

class MessageChatErrorState extends MessageChatState{
  final String errorMessage;
  MessageChatErrorState({required this.errorMessage});
}
