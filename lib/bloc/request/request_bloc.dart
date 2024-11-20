import 'package:chat_app/bloc/request/request_state.dart';
import 'package:chat_app/database/models/request.dart';
import 'package:chat_app/repository/request_repository.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'request_event.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final RequestRepository requestRepository = RequestRepository();
  final UserRepository userRepository = UserRepository();
  final AppLocalizations? appLocalizations;
  final List<Request> listRequest = [];

  RequestBloc(this.appLocalizations) : super(RequestInitial()) {
    on<RequestGetAllEvent>(_onGetAllRequest);
  }
  Future<void> _onGetAllRequest(
      RequestGetAllEvent event, Emitter<RequestState> emit) async {
    emit(RequestLoading());
    try {
      final sendRequest = await requestRepository.getAllRequest("fromUId");
      final receivedRequest = await requestRepository.getAllRequest("toUId");
      emit(RequestGetAllSuccessState(sendRequest, receivedRequest));
    } catch (e) {
      emit(RequestFailure(e.toString()));
    }
  }
}
