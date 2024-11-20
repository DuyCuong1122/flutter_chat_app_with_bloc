import 'dart:async';
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
  StreamSubscription<QuerySnapshot<Message>>? _messagesStreamSubscription;
  final List<Message> messagesList = [];

  MessageBloc({required this.appLocalizations}) : super(MessageInitial()) {
    on<MessageGetAllEvent>(_onGetAllMessage);
    on<MessageReadEvent>(_onReadMessage);
    on<MessageCreateEvent>(_onCreateMessage);
    on<MessageUpdateEvent>(_onMessagesUpdated);
    on<MessageSearchEvent>(_onSearchMessage);
    on<MessageCheckExistEvent>(_onMessageCheckExist);
    _startListeningToMessages();
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

  void _onMessagesUpdated(
      MessageUpdateEvent event, Emitter<MessageState> emit) {
    emit(MessageSuccess(messagesList: event.messageList));
  }

  void _onMessageCheckExist(
      MessageCheckExistEvent event, Emitter<MessageState> emit) async {
    emit(MessageLoading());
    try {
      final message = await _messageRepository.checkMessageExist(event.user);
      if (message != null) {
        emit(MessageExistState(message: message));
      } else {
        emit(MessageNotExistState());
      }
    } catch (e) {
      emit(MessageFailure(error: appLocalizations!.failedGetMessages));
    }
  }

  void _startListeningToMessages() {
    final messagesCollection = FirebaseFirestore.instance
        .collection("messages")
        .withConverter<Message>(
          fromFirestore: (snapshot, _) => Message.fromFirestore(snapshot),
          toFirestore: (Message msgContent, options) =>
              msgContent.toFirestore(),
        )
        .orderBy("lastTime", descending: false);
    messagesList.clear();
    _messagesStreamSubscription =
        messagesCollection.snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            final data = change.doc.data();
            if (data != null) {
              messagesList.insert(0, data);
            }
            break;

          case DocumentChangeType.modified:
            final updatedData = change.doc.data();
            if (updatedData != null) {
              final index =
                  messagesList.indexWhere((msg) => msg.id == updatedData.id);
              if (index != -1) {
                messagesList[index] = updatedData;
              }
            }
            break;

          case DocumentChangeType.removed:
            final removedData = change.doc.data();
            if (removedData != null) {
              messagesList.removeWhere((msg) => msg.id == removedData.id);
            }
            break;
        }
      }
      add(MessageUpdateEvent(messageList: List.from(messagesList)));
    }, onError: (error) {
      add(MessageErrorEvent(errorMessage: error.toString()));
    });
  }

  @override
  Future<void> close() {
    _messagesStreamSubscription?.cancel();
    return super.close();
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

  Future _onSearchMessage(
      MessageSearchEvent event, Emitter<MessageState> emit) async {
    emit(MessageLoading());
    try {
      final messages = await _messageRepository.searchMessagesInUserChats(event.query);
      emit(MessageSearchSuccess(results: messages));
    } catch (e) {
      emit(MessageFailure(error: "Fail to search message"));
    }
  }

}
