import 'package:chat_app/bloc/request/request_bloc.dart';
import 'package:chat_app/common/values/storage.dart';
import 'package:chat_app/database/models/user.dart';
import 'package:chat_app/database/services/shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
      final requestState = context.watch<RequestBloc>().state;
    return GestureDetector();
  }
}
