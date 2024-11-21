import 'package:chat_app/database/models/request.dart';

abstract class RequestActionEvent {}

class RequestCreateEvent extends RequestActionEvent {
  final Request request;
  RequestCreateEvent({required this.request});
}

class RequestAcceptEvent extends RequestActionEvent {
  final Request request;
  RequestAcceptEvent({required this.request});
}

class RequestDeleteEvent extends RequestActionEvent {
  final Request request;
  RequestDeleteEvent({required this.request});
}