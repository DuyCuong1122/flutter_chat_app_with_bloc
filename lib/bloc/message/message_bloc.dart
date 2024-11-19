import 'package:chat_app/bloc/message/message_event.dart';
import 'package:chat_app/bloc/message/message_state.dart';
import 'package:chat_app/common/values/storage.dart';
import 'package:chat_app/database/services/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../database/models/message.dart';
import '../../repository/message_repository.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository _messageRepository = MessageRepository();
  final AppLocalizations? appLocalizations;

  MessageBloc({required this.appLocalizations}) : super(MessageInitial()) {
    on<MessageGetAllEvent>(_onGetAllMessage);
    on<MessageReadEvent>(_onReadMessage);
    on<MessageCreateEvent>(_onCreateMessage);
  }

  Future _onGetAllMessage(
      MessageGetAllEvent event, Emitter<MessageState> emit) async {
    emit(MessageLoading());
    try {
      final messages = await _messageRepository.getAllListMessages();
      emit(MessageSuccess(messagesList: messages));
    } catch (e) {
      emit(MessageFailure(error: appLocalizations!.failedGetMessages));
    }
  }

  Future _onReadMessage(
      MessageReadEvent event, Emitter<MessageState> emit) async {
    emit(MessageLoading());
    try {
      await _messageRepository.updateUnreadMessage(event.message);
      emit(MessageReadSuccess());
    } catch (e) {
      emit(MessageFailure(error: "Fail to mark as read message"));
    }
  }

  Future _onCreateMessage(
      MessageCreateEvent event, Emitter<MessageState> emit) async {
    emit(MessageLoading());
    try {
      final Message message = Message()
        ..toName = event.toUser.name
        ..toUId = event.toUser.id
        ..toName = event.toUser.name
        ..fromUId = SharedPreferencesService().getString(ID)
        ..fromName = SharedPreferencesService().getString(NAME)
        ..lastSenderId = SharedPreferencesService().getString(ID);
      final response = await _messageRepository.createMessage(message);
      emit(MessageCreateSuccessState(message: response));
    } catch (e) {
      emit(MessageFailure(error: "Fail to create message"));
    }
  }
}
