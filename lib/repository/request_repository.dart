import 'dart:developer';

import 'package:chat_app/common/config/firebase_api.dart';
import 'package:chat_app/common/models/request.dart';

class RequestRepository {
  Future createRequest(Request request) async {
    try {
      await FirebaseApi.addDocument('requests', request.toFirestore());
    } catch (e) {
      log('Error creating request: $e');
    }
  }

  Future deleteRequest(String id) async {
    try {
      await FirebaseApi.deleteDocument('requests', id);
    } catch (e) {
      log('Error deleting request: $e');
    }
  }
}
