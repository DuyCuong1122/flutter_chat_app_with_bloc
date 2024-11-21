import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/database/models/message_content.dart';
import 'package:flutter/material.dart';
import '../../../database/models/message.dart';

Widget ChatRightItem(MessageContent item, Message message, BuildContext context,
    {bool isLast = false, String? time}) {
  final widthScreen = MediaQuery.of(context).size.width;
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ConstrainedBox(
            constraints: BoxConstraints(maxWidth: widthScreen * 0.76),
            child: Container(
              margin: const EdgeInsets.only( bottom: 3),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                item.content!,
                style: AppTypography.s16w500.copyWith(color: Colors.white),
              ),
            )),
        if (isLast) ...{
          Text(
            time!,
            style:
            AppTypography.s12w400.copyWith(color: AppColors.f99Color),
          ),
          const SizedBox(
            height: 17,
          )
        }
      ],
    ),
  );
}
