
import 'package:flutter/material.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/icons.dart';
import '../../../common/values/typography.dart';
import '../../../database/models/user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SentFriendItem extends StatelessWidget {
  final User user;
  const SentFriendItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
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
        ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: AppColors.primaryColor, width: 1),
          ),
        ), child: Text(AppLocalizations.of(context)!.cancel, style: AppTypography.s14w500,),),
      ],
    );
  }
}
