import 'package:cloud_firestore/cloud_firestore.dart';

class MessageContent {
  String? id;
  String? uid;
  String? content;
  String? type;
  Timestamp? createdAt;

  MessageContent({this.id, this.uid, this.content, this.type, this.createdAt});

  factory MessageContent.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return MessageContent(
      id: doc.id,
      uid: data['uid'] ?? '',
      content: data['content'] ?? '',
      type: data['type'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  factory MessageContent.fromMap(Map<String, dynamic> data) {
    return MessageContent(
      id: data['id'],
      uid: data['uid'],
      content: data['content'],
      type: data['type'],
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'content': content,
      'type': type,
      'createdAt': Timestamp.now(),
    };
  }
}