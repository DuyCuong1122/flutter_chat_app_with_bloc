import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:flutter/material.dart';

class ProfileCustomButton extends StatelessWidget {
  final String icon;
  final String text;
  final String? subtile;
  final bool suffixIcon;
  final bool isLogout;
  final Function() onTap;
  final bool isVersion;
  const ProfileCustomButton(
      {super.key,
      required this.icon,
      required this.text,
      this.subtile,
      required this.suffixIcon,
      required this.onTap,
      required this.isLogout,
      required this.isVersion});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 72,
        width: double.infinity,
    
          color: Colors.white,
        
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Image.asset(icon),
              const SizedBox(width: 18),
              Text(
                text,
                style: AppTypography.s18w500.copyWith(
                  color: isLogout ? AppColors.errorColor : AppColors.blackColor,
                ),
              ),
              const Spacer(),
              if (subtile != null)
                Text(subtile!,
                    style: AppTypography.s16w500.copyWith(
                        color: isVersion
                            ? AppColors.f99Color
                            : AppColors.primaryColor)),
              const SizedBox(
                width: 12,
              ),
              if (suffixIcon)
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.f99Color,
                  size: 14,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
