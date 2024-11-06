import 'package:cloud_firestore/cloud_firestore.dart';

class Message
{
  String? id;
  String? fromUId;
  String? toUId;
  String? lastMessage;
  Timestamp? lastMessageTime; 
  bool? isRead;
  String? fromName;
  String? toName;

  Message({
    this.id,
    this.fromUId,
    this.toUId,
    this.lastMessage,
    this.lastMessageTime,
    this.isRead,
    this.fromName,
    this.toName,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Message(
      id: doc.id,
      fromUId: data['from_uid'] ?? '',
      toUId: data['to_uid'] ?? '',
      lastMessage: data['last_message'] ?? '',
      lastMessageTime: data['last_time'] ?? Timestamp.now(),
      isRead: data['is_read'],
      fromName: data['from_name'] ?? '',
      toName: data['to_name'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'from_uid': fromUId,
      'to_uid': toUId,
      'last_message': lastMessage,
      'last_time': lastMessageTime,
      'is_read': isRead,
      'from_name': fromName,
      'to_name': toName,
    };
  }

  @override
  String toString() {
    return 'Message{id: $id, fromUId: $fromUId, toUId: $toUId, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, isRead: $isRead, fromName: $fromName, toName: $toName}';
  }
}