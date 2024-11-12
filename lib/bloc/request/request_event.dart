import 'package:chat_app/database/models/request.dart';

abstract class RequestEvent {}

class RequestGetSentEvent extends RequestEvent {}

class RequestGetReceivedEvent extends RequestEvent {}

class RequestCreateEvent extends RequestEvent {
  final Request request;
  RequestCreateEvent({required this.request});
}

class RequestAcceptEvent extends RequestEvent {
  final Request request;
  RequestAcceptEvent({required this.request});
}

class RequestDeleteEvent extends RequestEvent {
  final Request request;
  RequestDeleteEvent({required this.request});
}