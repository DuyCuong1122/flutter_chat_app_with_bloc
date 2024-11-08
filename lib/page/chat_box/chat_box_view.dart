import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/page/chat_box/widget/send_message_item.dart';
import 'package:flutter/material.dart';

class ChatBoxView extends StatelessWidget {
  final String name;
  const ChatBoxView({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
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
                      AppColor.primaryColor,
                      AppColor.secondaryColor,
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
                name,
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
              color: AppColor.primaryColor,
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
          child: Column(
            children: [Expanded(child: Text("Chat Box")), SendMessageItem(  )],
          ),
        ),
      ),
    );
  }
}
