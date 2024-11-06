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
      createdAt: data['created_at'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'content': content,
      'type': type,
      'created_at': Timestamp.now(),
    };
  }
}