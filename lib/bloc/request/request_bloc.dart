import 'package:chat_app/bloc/request/request_state.dart';
import 'package:chat_app/repository/request_repository.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'request_event.dart';

class RequestBloc extends Bloc<RequestEvent,RequestState> {
  final RequestRepository requestRepository = RequestRepository();
  final UserRepository userRepository = UserRepository();
  final AppLocalizations? appLocalizations ;
  RequestBloc(this.appLocalizations) : super(RequestInitial()) {
    on<RequestGetSentEvent>(_onGetSentRequest);
    on<RequestCreateEvent>(_onCreateRequest);
    on<RequestAcceptEvent>(_onAcceptRequest);
    on<RequestDeleteEvent>(_onDeleteRequest);
    on<RequestGetReceivedEvent>(_onGetReceiveRequest);
  }
  Future<void> _onGetSentRequest(RequestGetSentEvent event, Emitter<RequestState> emit) async {
  emit(RequestLoading());
  try {
    final requests = await requestRepository.getRequest("fromUId");
    emit(RequestGetAllReceivedSuccessState(requests));
  } catch (e) {
    emit(RequestFailure(e.toString()));
  }
}

Future<void> _onGetReceiveRequest(RequestGetReceivedEvent event, Emitter<RequestState> emit) async {
  emit(RequestLoading());
  try {
    final requests = await requestRepository.getRequest("toUId");
    emit(RequestGetAllReceivedSuccessState(requests));
  } catch (e) {
    emit(RequestFailure(e.toString()));
  }
}

Future<void> _onCreateRequest(RequestCreateEvent event, Emitter<RequestState> emit) async {
  emit(RequestLoading());
  try {
    await requestRepository.createRequest(event.request);
    emit(RequestCreateSuccessState(appLocalizations!.successfullyAddFriendRequest));
  } catch (e) {
    emit(RequestFailure(e.toString()));
  }
}

Future<void> _onAcceptRequest(RequestAcceptEvent event, Emitter<RequestState> emit) async {
  emit(RequestLoading());
  try {
    await requestRepository.deleteRequest(event.request.id!);
    emit(RequestAcceptSuccessState());
  } catch (e) {
    emit(RequestFailure(e.toString()));
  }
}

Future<void> _onDeleteRequest(RequestDeleteEvent event, Emitter<RequestState> emit) async {
  emit(RequestLoading());
  try {
    await requestRepository.deleteRequest(event.request.id!);
    emit(RequestDeleteSuccessState());
  } catch (e) {
    emit(RequestFailure(e.toString()));
  }
}
}

