import 'package:chat_app/database/models/message.dart';

class MessageEvent {}


class MessageGetAllEvent extends MessageEvent {

}

class MessageReadEvent extends MessageEvent {
  final Message message;

  MessageReadEvent({required this.message});
}