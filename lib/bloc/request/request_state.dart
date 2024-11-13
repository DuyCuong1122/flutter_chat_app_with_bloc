import 'package:chat_app/database/models/request.dart';

abstract class RequestState {}

class RequestInitial extends RequestState {}

class RequestLoading extends RequestState {}

class RequestSuccess extends RequestState {
}

class RequestFailure extends RequestState {
  final String message;
  RequestFailure(this.message);
}

class RequestGetAllSuccessState extends RequestState {
  final List<Request> sendRequest;
  final List<Request> receivedRequest;
  RequestGetAllSuccessState( this.sendRequest, this.receivedRequest);
}

class RequestDeleteSuccessState extends RequestState {

} 

class RequestCreateSuccessState extends RequestState {
  final String message;
  RequestCreateSuccessState(this.message);
}

class RequestAcceptSuccessState extends RequestState {
  final String message;
  RequestAcceptSuccessState(this.message);
}

