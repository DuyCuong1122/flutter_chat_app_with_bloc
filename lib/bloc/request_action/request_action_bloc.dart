import 'package:chat_app/common/values/storage.dart';
import 'package:chat_app/database/services/service.dart';
import 'package:chat_app/repository/request_repository.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'request_action_event.dart';
import 'request_action_state.dart';

class RequestActionBloc extends Bloc<RequestActionEvent, RequestActionState>{
  final RequestRepository requestRepository = RequestRepository();
  final UserRepository userRepository = UserRepository();
  final AppLocalizations? appLocalizations;
  RequestActionBloc(
    this.appLocalizations,
  ) : super(RequestActionInitial()) {
    on<RequestAcceptEvent>(_onAcceptRequest);
    on<RequestCreateEvent>(_onCreateRequest);
    on<RequestDeleteEvent>(_onDeleteRequest);
  }

  Future<void> _onCreateRequest(RequestCreateEvent event, Emitter<RequestActionState> emit) async {
  emit(RequestActionLoading());
  try {
    await requestRepository.createRequest(event.request);
    emit(RequestActionSuccess(appLocalizations!.successfullyAddFriendRequest));
  } catch (e) {
    emit(RequestActionFailure(e.toString()));
  }
}

Future<void> _onAcceptRequest(RequestAcceptEvent event, Emitter<RequestActionState> emit) async {
  emit(RequestActionLoading());
  try {
    Future.wait([
      requestRepository.deleteRequest(event.request.id!),
      userRepository.addFriend(event.request.fromUId!),
    ]);
    List<String> friends = SharedPreferencesService().getList(LIST_FRIENDS);
    friends.add(event.request.fromUId!);
    SharedPreferencesService().setList(LIST_FRIENDS, friends);
    emit(RequestActionSuccess(appLocalizations!.successfullyAcceptFriend));
  } catch (e) {
    emit(RequestActionFailure(e.toString()));
  }
}

Future<void> _onDeleteRequest(RequestDeleteEvent event, Emitter<RequestActionState> emit) async {
  emit(RequestActionLoading());
  try {
    await requestRepository.deleteRequest(event.request.id!);
    emit(RequestActionSuccess(""));
  } catch (e) {
    emit(RequestActionFailure(e.toString()));
  }
}
}