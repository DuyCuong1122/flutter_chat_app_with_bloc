import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/common/widgets/default_avatar.dart';
import 'package:chat_app/database/models/message_content.dart';
import 'package:flutter/material.dart';

import '../../../database/models/message.dart';

Widget ChatLeftItem(MessageContent item, Message message, BuildContext context,
    {bool isLast = false, String? time}) {
  final widthScreen = MediaQuery.of(context).size.width;
  return Container(
    padding: const EdgeInsets.symmetric( vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        isLast
            ? const Padding(
              padding: EdgeInsets.only(top: 5),
              child: DefaultAvatar(
                  size: 35,
                ),
            )
            : const SizedBox(
                width: 35,
              ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
                constraints: BoxConstraints(maxWidth: widthScreen * 0.76),
                child: Container(
                  margin: const EdgeInsets.only(left: 10, bottom: 3),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0x10393939),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    item.content!,
                    style: AppTypography.s16w500.copyWith(color: Colors.black),
                  ),
                )),
            if (isLast) ...{
              Padding(
                padding: const EdgeInsets.only(left: 12,),
                child: Text(
                  time!,
                  style:
                  AppTypography.s12w400.copyWith(color: AppColors.f99Color),
                ),
              ),
              const SizedBox(
                height: 17,
              )
            }
          ],
        ),
      ],
    ),
  );
}
