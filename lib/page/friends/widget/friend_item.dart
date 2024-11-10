import 'package:chat_app/common/models/model.dart';
import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FriendItem extends StatelessWidget {
  final User user;
  final String type;
  const FriendItem({super.key, required this.user, this.type = ''});

  Widget buildButtonOption(String type, BuildContext context) {
    if (type == AppLocalizations.of(context)!.all) {
      return Container(
        height: 27,
        width: 73,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColor.primaryColor,
        ),
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.addFriend,
            style: AppTypography.s14w500.copyWith(color: Colors.white),
          ),
        ),
      );
    }
    if (type == AppLocalizations.of(context)!.friendRequests) {
      return Container(
        height: 27,
        width: 73,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColor.primaryColor,
        ),
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.accept,
            style: AppTypography.s14w500.copyWith(color: Colors.white),
          ),
        ),
      );
    }
    if (type == AppLocalizations.of(context)!.sentFriend) {
      return Container(
        height: 27,
        width: 73,
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.primaryColor),
            borderRadius: BorderRadius.circular(30),
            color: Colors.white),
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.cancel,
            style: AppTypography.s14w500.copyWith(color: AppColor.primaryColor),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColor.primaryColor,
                  AppColor.secondaryColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const Icon(
              AppIcon.person,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Text(
            user.name.toString(),
            style: AppTypography.s16w800,
          )),
          buildButtonOption(type, context),
        ],
      ),
    );
  }
}
