import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/page/chat_box/widget/send_message_item.dart';
import 'package:flutter/material.dart';

import '../../common/values/storage.dart';
import '../../database/models/message.dart';
import '../../database/services/shared_preference_service.dart';

class ChatBoxView extends StatelessWidget {
  final Message message;

  ChatBoxView({super.key, required this.message});

  String userId = SharedPreferencesService().getString(ID);

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.f6Color,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: heightScreen * 0.12,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primaryColor,
                      AppColors.secondaryColor,
                    ],
                  ),
                ),
                child: Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                userId == message.fromUId ? message.toName! : message.fromName!,
                style: AppTypography.s18w800.copyWith(color: Colors.black),
              )
            ],
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              AppIcon.back,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: const Column(
            children: [Expanded(child: Text("Chat Box")), SendMessageItem()],
          ),
        ),
      ),
    );
  }
}
