import 'package:chat_app/common/util/change_date_to_text.dart';
import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/common/widgets/default_avatar.dart';
import 'package:chat_app/database/models/message.dart';
import 'package:chat_app/page/chat_box/chat_box_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common/values/storage.dart';
import '../../../database/services/shared_preference_service.dart';

class SearchMessageItem extends StatelessWidget {
  final Message message;
  final String count;
  const SearchMessageItem({super.key, required this.message, required this.count});

  @override
  Widget build(BuildContext context) {
    String userId = SharedPreferencesService().getString(ID);
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatBoxView(
            message: message,
          );
        }));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        color: Colors.transparent,
        child: Row(
          children: [
            const DefaultAvatar(size: 54),
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
                          style: AppTypography.s12w500
                              .copyWith(color: AppColors.normalColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$count ${AppLocalizations.of(context)!.suitableMessage}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.s14w500
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
