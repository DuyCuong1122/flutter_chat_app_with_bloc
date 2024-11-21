import 'package:chat_app/database/services/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/storage.dart';
import '../../../database/models/message.dart';
import '../../../database/models/message_content.dart';
import 'chat_left_hand.dart';
import 'chat_right_hand.dart';

class ChatList extends StatelessWidget {
  final List<MessageContent> msgContentList;
  final Message message;

  const ChatList(
      {super.key, required this.msgContentList, required this.message});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppColors.whiteColor,
        padding: const EdgeInsets.only(bottom: 5),
        child: CustomScrollView(
          reverse: true,
          slivers: [
            SliverPadding(
              padding: EdgeInsets.zero,
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                bool isLast = false;
                String time = '';
                var item = msgContentList[index];
                if (index == 0 ||
                    item.uid != msgContentList[index -1].uid) {
                  isLast = true;
                  time = DateFormat('HH:mm').format(item.createdAt != null
                      ? item.createdAt!.toDate()
                      : DateTime.now());
                }
                if (item.uid != SharedPreferencesService().getString(ID)) {
                  return ChatLeftItem(item, message, context,
                      isLast: isLast, time: time);

                }
                return ChatRightItem(item, message, context,
                    isLast: isLast, time: time);
              }, childCount: msgContentList.length)),
            )
          ],
        ),
      ),
    );
  }
}
