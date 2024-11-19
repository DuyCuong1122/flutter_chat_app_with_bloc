import 'dart:async';

import 'package:chat_app/bloc/message_chat/message_chat_event.dart';
import 'package:chat_app/bloc/message_chat/message_chat_state.dart';
import 'package:chat_app/repository/message_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/models/message.dart';
import '../../database/models/message_content.dart';

class MessageChatBloc extends Bloc<MessageChatEvent, MessageChatState> {
  final List<MessageContent> messagesList = [];
  final MessageRepository messageRepository = MessageRepository();
  final Message message;
  StreamSubscription<QuerySnapshot<MessageContent>>?
      _messagesStreamSubscription;

  MessageChatBloc({required this.message}) : super(MessageChatInitialState()) {
    on<MessageSendEvent>(onMessageSend);
    on<MessageGetAllChatEvent>(onMessageGetAllChat);
    _startListeningToMessages();
  }

  Future onMessageSend(
      MessageSendEvent event, Emitter<MessageChatState> emit) async {
    emit(MessageChatLoadingState());
    await messageRepository
        .createChatMessage(event.messageContent, event.message)
        .then((value) {
      messagesList.insert(0, event.messageContent);
      emit(MessageChatSuccessState(messagesList: messagesList));
    }).catchError((error) {
      emit(MessageChatErrorState(errorMessage: error.toString()));
    });
  }

  void onMessageGetAllChat(
      MessageGetAllChatEvent event, Emitter<MessageChatState> emit) {
    emit(MessageChatLoadingState());
    messageRepository.getAllChatListMessages(event.message.id!).then((value) {
      messagesList.addAll(value);
      emit(MessageChatSuccessState(messagesList: messagesList));
    }).catchError((error) {
      emit(MessageChatErrorState(errorMessage: error.toString()));
    });
  }

  void _onMessagesUpdated(
      MessagesUpdatedEvent event, Emitter<MessageChatState> emit) {
    emit(MessageChatSuccessState(messagesList: event.messagesList));
  }

  void _startListeningToMessages() {
    final messagesCollection = FirebaseFirestore.instance
        .collection("messages")
        .doc(message.id)
        .collection("msgList")
        .withConverter<MessageContent>(
          fromFirestore: (snapshot, _) =>
              MessageContent.fromFirestore(snapshot, null),
          toFirestore: (MessageContent msgContent, options) =>
              msgContent.toJson(),
        )
        .orderBy("createAt", descending: false);

    _messagesStreamSubscription =
        messagesCollection.snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            final data = change.doc.data();
            if (data != null) {
              messagesList.insert(0, data); // Không cần chuyển đổi nữa
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

      // Phát sự kiện cập nhật state
      add(MessagesUpdatedEvent(messagesList: List.from(messagesList)));
    }, onError: (error) {
      add(MessageChatErrorEvent(errorMessage: error.toString()));
    });
  }

  @override
  Future<void> close() {
    _messagesStreamSubscription?.cancel();
    return super.close();
  }
}
