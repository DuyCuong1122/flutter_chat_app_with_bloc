abstract class RequestActionState {}

class RequestActionInitial extends RequestActionState {}

class RequestActionLoading extends RequestActionState {}

class RequestActionSuccess extends RequestActionState {
  final String message;
  RequestActionSuccess(this.message);
}

class RequestActionFailure extends RequestActionState {
  final String? message;
  RequestActionFailure(this.message);
}