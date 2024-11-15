
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

class MessageFailure extends MessageState {
  final String error;
  MessageFailure({required this.error});
}

class MessageReadSuccess extends MessageState {
  MessageReadSuccess();
}
