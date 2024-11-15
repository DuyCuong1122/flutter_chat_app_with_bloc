import 'package:chat_app/bloc/message/message_event.dart';
import 'package:chat_app/bloc/message/message_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../repository/message_repository.dart';

class MessageBloc extends Bloc<MessageEvent,MessageState>{
  final MessageRepository _messageRepository = MessageRepository();
  final AppLocalizations appLocalizations;
  MessageBloc(
    {required this.appLocalizations}
      ) : super(MessageInitial()){
    on<MessageGetAllEvent>(_onGetAllMessage);
  }

  Future _onGetAllMessage(MessageGetAllEvent event, Emitter<MessageState> emit) async {
    emit(MessageLoading());
    try {
      final messages = await _messageRepository.getAllListMessages();
      emit(MessageSuccess(messagesList: messages));
    } catch (e) {
      emit(MessageFailure(error: appLocalizations.failedGetMessages));
    }
  }

  Future _onReadMessage(MessageReadEvent event, Emitter<MessageState> emit) async {
    emit(MessageLoading());
    try {
      await _messageRepository.updateUnreadMessage(event.message);
      emit(MessageReadSuccess());
    } catch (e) {
      emit(MessageFailure(error: "Fail to mark as read message"));
    }
  }
}