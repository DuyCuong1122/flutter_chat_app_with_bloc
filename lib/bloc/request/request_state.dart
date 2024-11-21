import 'package:chat_app/database/models/request.dart';

class RequestState {
  final int requestCount;
  RequestState({this.requestCount = 0});
}

class RequestInitial extends RequestState {}

class RequestLoading extends RequestState {}

class RequestFailure extends RequestState {
  final String message;
  RequestFailure(this.message);
}

class RequestGetAllSuccessState extends RequestState {
  final List<Request> sendRequest;
  final List<Request> receivedRequest;
  RequestGetAllSuccessState(this.sendRequest, this.receivedRequest)
      : super(requestCount: receivedRequest.length);
}
