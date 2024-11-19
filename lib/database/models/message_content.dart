import 'package:chat_app/common/values/storage.dart';
import 'package:chat_app/database/services/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageContent {
  String? id;
  String? uid;
  String? content;
  String? type;
  Timestamp? createdAt;

  MessageContent({this.id, this.uid, this.content, this.type, this.createdAt});

  factory MessageContent.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc, SnapshotOptions? options,) {
    final data = doc.data() ;
    return MessageContent(
      id:  doc.id,
      uid: data?['uid'] ?? '',
      content: data?['content'] ?? '',
      type: data?['type'] ?? '',
      createdAt: data?['createdAt'] ?? Timestamp.now(),
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
      'uid': SharedPreferencesService().getString(ID),
      'content': content,
      'type': 'text',
      'createdAt': Timestamp.now(),
    };
  }

  @override
  String toString() {
    return 'MessageContent{id: $id, uid: $uid, content: $content, type: $type, createdAt: $createdAt}';
  }
}
