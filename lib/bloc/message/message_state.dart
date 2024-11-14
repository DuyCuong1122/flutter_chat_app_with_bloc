import 'package:equatable/equatable.dart';

import '../../database/models/message.dart';

class MessageState extends Equatable {
  final List<Message> messages;

  const MessageState({ required this.messages});


  @override
  List<Object> get props => [messages];
}

class MessageInitial extends MessageState {
  MessageInitial() : super(messages: []);
}

class MessageLoading extends MessageState {
  MessageLoading() : super(messages: []);
}

class MessageLoaded extends MessageState {
  MessageLoaded({required super.messages});
}