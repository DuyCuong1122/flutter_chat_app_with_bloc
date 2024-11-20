
import '../../database/models/message.dart';

class MessageState {}

class MessageInitial extends MessageState {
  MessageInitial();
}

class MessageLoading extends MessageState {
  MessageLoading();
}

class MessageSuccess extends MessageState {
  final List<Message> messagesList;
  MessageSuccess({required this.messagesList});
}

class MessageSearchSuccess extends MessageState {
  final List<Map<String, dynamic>> results;
  MessageSearchSuccess({required this.results});
}

class MessageFailure extends MessageState {
  final String error;
  MessageFailure({required this.error});
}

class MessageReadSuccess extends MessageState {
  MessageReadSuccess();
}

class MessageCreateSuccessState extends MessageState{
  final Message message;
  MessageCreateSuccessState({required this.message});
}
