import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/database/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableItem extends StatelessWidget {
  final String text;
  final User user;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const SlidableItem({
    super.key,
    required this.text,
    required this.onAccept,
    required this.onReject,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => onReject(),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.close,
              label: 'Từ chối',
            ),
          ],
        ),
        child: Container(
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
                  user.name!,
                  style: AppTypography.s16w800
                      .copyWith(color: AppColors.blackColor),
                ),
              ),
              ElevatedButton(
                onPressed: () => onAccept(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  text,
                  style: AppTypography.s14w500.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
