import 'package:cloud_firestore/cloud_firestore.dart';

class Request{
  String? id;
  String? fromUId;
  String? toUId;
  String? fromName;
  String? toName;
  Timestamp? createdAt;

  Request({
    this.id,
    this.fromUId,
    this.toUId,
    this.fromName,
    this.toName,
    this.createdAt,
  });

  factory Request.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Request(
      id: doc.id,
      fromUId: data['from_uid'] ?? '',
      toUId: data['to_uid'] ?? '',
      fromName: data['from_name'] ?? '',
      toName: data['to_name'] ?? '',
      createdAt: data['created_at'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'from_uid': fromUId,
      'to_uid': toUId,
      'from_name': fromName,
      'to_name': toName,
      'created_at': Timestamp.now(),
    };
  }
}