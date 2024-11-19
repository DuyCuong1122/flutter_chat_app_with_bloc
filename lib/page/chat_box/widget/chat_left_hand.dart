import 'package:chat_app/database/models/message_content.dart';
import 'package:flutter/material.dart';

import '../../../database/models/message.dart';

Widget ChatLeftItem(MessageContent item, Message message, BuildContext context) {
  final widthScreen = MediaQuery.of(context).size.width;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // ConstrainedBox(
        //     constraints: BoxConstraints(maxWidth: 230.w, minHeight: 40.w),
        //     child: Container(
        //         margin: EdgeInsets.only(right: 10.w, top: 0.w),
        //         padding: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
        //         decoration: const BoxDecoration(
        //             color: Color(0xFF393939),
        //             borderRadius: BorderRadius.all(Radius.circular(30))),
        //         child: Text("${item.content}")))
      ],
    ),
  );
}
