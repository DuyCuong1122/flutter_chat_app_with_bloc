import 'package:cloud_firestore/cloud_firestore.dart';

class Message
{
  String? id;
  String? fromUId;
  String? toUId;
  String? lastMessage;
  Timestamp? lastTime; 
  String? fromName;
  String? toName;
  int? unreadCount;
  String? lastSenderId;

  Message({
    this.id,
    this.fromUId,
    this.toUId,
    this.lastMessage,
    this.lastTime,
    this.fromName,
    this.toName,
    this.unreadCount = 0,
    this.lastSenderId,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Message(
      id: doc.id,
      fromUId: data['fromUId'] ?? '',
      toUId: data['toUId'] ?? '',
      lastMessage: data['lastMessage'] ?? '',
      lastTime: data['lastTime'] ?? Timestamp.now(),
      fromName: data['fromName'] ?? '',
      toName: data['toName'] ?? '',
      unreadCount: data['unreadCount'] ?? 0,
      lastSenderId: data['lastSenderId'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'fromUId': fromUId,
      'toUId': toUId,
      'lastMessage': lastMessage,
      'lastTime': lastTime,
      'fromName': fromName,
      'toName': toName,
      'unreadCount': unreadCount,
      'lastSenderId': lastSenderId,
    };
  }

  factory Message.fromMap(Map<String, dynamic> data) {
    return Message(
      id: data['id'],
      fromUId: data['fromUId'],
      toUId: data['toUId'],
      lastMessage: data['lastMessage'],
      lastTime: data['lastTime'],
      fromName: data['fromName'],
      toName: data['toName'],
      unreadCount: data['unreadCount'] ?? 0,
      lastSenderId: data['lastSenderId'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Message{id: $id, fromUId: $fromUId, toUId: $toUId, lastMessage: $lastMessage, lastTime: $lastTime, fromName: $fromName, toName: $toName, unreadCount: $unreadCount, lastSenderId: $lastSenderId}';
  }
}