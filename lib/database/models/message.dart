import 'package:cloud_firestore/cloud_firestore.dart';

class Message
{
  String? id;
  String? fromUId;
  String? toUId;
  String? lastMessage;
  Timestamp? lastTime; 
  bool? isRead;
  String? fromName;
  String? toName;
  int? unreadCount;

  Message({
    this.id,
    this.fromUId,
    this.toUId,
    this.lastMessage,
    this.lastTime,
    this.isRead,
    this.fromName,
    this.toName,
    this.unreadCount,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Message(
      id: doc.id,
      fromUId: data['fromUId'] ?? '',
      toUId: data['toUId'] ?? '',
      lastMessage: data['lastMessage'] ?? '',
      lastTime: data['lastTime'] ?? Timestamp.now(),
      isRead: data['isRead']?? false,
      fromName: data['fromName'] ?? '',
      toName: data['toName'] ?? '',
      unreadCount: data['unreadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'fromUId': fromUId,
      'toUId': toUId,
      'lastMessage': lastMessage,
      'lastTime': lastTime,
      'isRead': isRead,
      'fromName': fromName,
      'toName': toName,
      'unreadCount': unreadCount,
    };
  }

  factory Message.fromMap(Map<String, dynamic> data) {
    return Message(
      id: data['id'],
      fromUId: data['fromUId'],
      toUId: data['toUId'],
      lastMessage: data['lastMessage'],
      lastTime: data['lastTime'],
      isRead: data['isRead'],
      fromName: data['fromName'],
      toName: data['toName'],
      unreadCount: data['unreadCount'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Message{id: $id, fromUId: $fromUId, toUId: $toUId, lastMessage: $lastMessage, lastTime: $lastTime, isRead: $isRead, fromName: $fromName, toName: $toName}';
  }
}