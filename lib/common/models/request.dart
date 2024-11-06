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
      fromUId: data['fromUId'] ?? '',
      toUId: data['toUId'] ?? '',
      fromName: data['fromName'] ?? '',
      toName: data['toName'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'fromUId': fromUId,
      'toUId': toUId,
      'fromName': fromName,
      'toName': toName,
      'createdAt': Timestamp.now(),
    };
  }

  factory Request.fromMap(Map<String, dynamic> data) {
    return Request(
      id: data['id'],
      fromUId: data['fromUId'],
      toUId: data['toUId'],
      fromName: data['fromName'],
      toName: data['toName'],
      createdAt: data['createdAt'],
    );
  }
}