import 'package:chat_app/common/util/change_date_to_text.dart';
import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/storage.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/database/models/message.dart';
import 'package:chat_app/database/services/service.dart';
import 'package:chat_app/page/chat_box/chat_box_view.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final Message message;

  MessageItem({super.key, required this.message});

  String userId = SharedPreferencesService().getString(ID);

  @override
  Widget build(BuildContext context) {
    bool isNewMessage =
        message.lastSenderId != userId && message.unreadCount != 0;
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ChatBoxView(
          message: message,
        );
      })),
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        color: Colors.transparent,
        child: Row(
          children: [
            Stack(children: [
              Container(
                padding: EdgeInsets.all(
                    isNewMessage ? 2 : 0), // Khoảng trắng giữa border và avatar
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white, // Màu trắng làm viền cách biệt
                  border: isNewMessage
                      ? Border.all(
                          color: AppColors.primaryColor,
                          width: 2,
                        )
                      : null,
                ),
                child: Container(
                  height: isNewMessage ? 54 : 58,
                  width: isNewMessage ? 54 : 58,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      AppColors.primaryColor,
                      AppColors.secondaryColor,
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.grey[300],
                  ),
                ),
              ),
              if (isNewMessage)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color(0xFFC92323),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        message.unreadCount.toString(),
                        style: AppTypography.s12w500.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ]),
            const SizedBox(width: 19),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 5, bottom: 29),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.normalColor,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          userId == message.fromUId
                              ? message.toName!
                              : message.fromName!,
                          style: AppTypography.s16w800
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          formatMessageDate(message.lastTime!, context),
                          style: AppTypography.s12w500.copyWith(
                              color: isNewMessage
                                  ? Colors.black
                                  : AppColors.normalColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      message.lastMessage!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: isNewMessage
                          ? AppTypography.s14w700.copyWith(color: Colors.black)
                          : AppTypography.s14w500
                              .copyWith(color: AppColors.normalColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
