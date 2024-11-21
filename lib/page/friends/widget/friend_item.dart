import 'package:chat_app/database/models/model.dart';
import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:flutter/material.dart';

class FriendItem extends StatelessWidget {
  final User user;
  final Function()? onTap;
  const FriendItem({
    super.key,
    required this.user, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
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
                    AppColors.primaryColor,
                    AppColors.secondaryColor,
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
              style: AppTypography.s16w800.copyWith(color: AppColors.blackColor),
            )),
          ],
        ),
      ),
    );
  }
}
