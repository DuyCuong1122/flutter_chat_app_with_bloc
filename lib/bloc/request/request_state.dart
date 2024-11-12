import 'package:chat_app/common/models/request.dart';

abstract class RequestState {}

class RequestInitial extends RequestState {}

class RequestLoading extends RequestState {}

class RequestSuccess extends RequestState {
  final String message;
  RequestSuccess(this.message);
}

class RequestFailure extends RequestState {
  final String message;
  RequestFailure(this.message);
}

class RequestGetAllSuccessState extends RequestState {
  final List<Request> requests;
  RequestGetAllSuccessState(this.requests);
}

class RequestGetAllSentSuccessState extends RequestState {
  final List<Request> requests;
  RequestGetAllSentSuccessState(this.requests);
}

class RequestGetAllReceivedSuccessState extends RequestState {
  final List<Request> requests;
  RequestGetAllReceivedSuccessState(this.requests);
}

class RequestUpdateSuccessState extends RequestState {
  final String message;
  RequestUpdateSuccessState(this.message);
}

class RequestDeleteSuccessState extends RequestState {
  final String message;
  RequestDeleteSuccessState(this.message);
} 

class RequestCreateSuccessState extends RequestState {
  final String message;
  RequestCreateSuccessState(this.message);
}

class RequestAcceptSuccessState extends RequestState {
  final String message;
  RequestAcceptSuccessState(this.message);
}

class RequestDeclineSuccessState extends RequestState {
  final String message;
  RequestDeclineSuccessState(this.message);
}

class RequestCancelSuccessState extends RequestState {
  final String message;
  RequestCancelSuccessState(this.message);
}

