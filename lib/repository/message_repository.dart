import 'dart:developer';
import 'package:chat_app/common/values/storage.dart';
import 'package:chat_app/database/models/message_content.dart';
import 'package:chat_app/database/services/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../common/config/firebase_api.dart';
import '../database/models/message.dart';

class MessageRepository {
  Future<List<Message>> getAllListMessages() async {
    try {
      final response = await FirebaseApi.getAllDocuments('messages');
      return response.isNotEmpty
          ? response.map((e) => Message.fromFirestore(e)).toList()
          : [];
    } catch (e) {
      log('Error getting messages: $e');
    }
    return [];
  }

  Future createMessage(Message message) async {
    try {
      await FirebaseApi.addDocument('messages', message.toFirestore());
    } catch (e) {
      log('Error creating message: $e');
    }
  }

  Future deleteMessage(String id) async {
    try {
      await FirebaseApi.deleteDocument('messages', id);
    } catch (e) {
      log('Error deleting message: $e');
    }
  }

  Future createChatMessage(
      MessageContent messageContent, Message message) async {
    try {
      if (message.lastSenderId == SharedPreferencesService().getString(ID)) {
        message.unreadCount = message.unreadCount! + 1;
      } else {
        message.unreadCount = 1;
      }
      await FirebaseApi.db
          .collection('messages')
          .doc(message.id)
          .collection('msgList')
          .add(messageContent.toJson())
          .then((DocumentReference doc) {
        log("Document snapshot added with id, ${doc.id}");
      });
      await FirebaseApi.db.collection('messages').doc(message.id).update({
        'lastMessage': messageContent.content,
        'lastTime': messageContent.createdAt,
        'lastSender': SharedPreferencesService().getString(ID),
        'unreadCount': message.unreadCount,
      });
    } catch (e) {
      log('Error creating chat message: $e');
    }
  }

  Future<List<MessageContent>> getAllChatListMessages(String messageId) async {
    try {
      final response = await FirebaseApi.db
          .collection('messages')
          .doc(messageId)
          .collection('msgList')
          .orderBy('createdAt', descending: true)
          .get();
      return response.docs.isNotEmpty
          ? response.docs.map((e) => MessageContent.fromFirestore(e)).toList()
          : [];
    } catch (e) {
      log('Error getting chat messages: $e');
    }
    return [];
  }

  Future updateUnreadMessage(Message message) async {
    if (message.unreadCount! > 0 &&
        message.lastSenderId != SharedPreferencesService().getString(ID)) {
      message.unreadCount = 0;
      try {
        await FirebaseApi.updateDocument(
            'messages', message.id!, message.toFirestore());
      } catch (e) {
        log('Error updating message: $e');
      }
    }
  }
}
