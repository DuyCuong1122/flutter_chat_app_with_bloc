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

class RequestGetAllSentSuccessState extends RequestState {
  final List<Request> requests;
  RequestGetAllSentSuccessState(this.requests);
}

class RequestGetAllReceivedSuccessState extends RequestState {
  final List<Request> requests;
  RequestGetAllReceivedSuccessState(this.requests);
}

class RequestDeleteSuccessState extends RequestState {

} 

class RequestCreateSuccessState extends RequestState {
  final String message;
  RequestCreateSuccessState(this.message);
}

class RequestAcceptSuccessState extends RequestState {

}

