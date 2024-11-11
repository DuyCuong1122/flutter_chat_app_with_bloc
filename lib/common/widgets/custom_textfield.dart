import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData? suffixIcon;
  final String? suffixAssetIcon;
  final TextEditingController controller;
  final bool ispassword;
  final String? errorText;
  final void Function(String)? onChanged;
  final String? hintText;
  final bool? readOnly;
  final Function()? onTap;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.suffixIcon,
    required this.controller,
    this.ispassword = false,
    this.onChanged,
    this.errorText,
    this.hintText,
    this.suffixAssetIcon,
    this.readOnly = false, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 1),
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: ispassword,
            decoration: InputDecoration(
              labelText: labelText.toUpperCase(),
              labelStyle:
                  AppTypography.s14w500.copyWith(color: AppColors.normalColor),
              suffixIcon: suffixIcon != null
                  ? Icon(suffixIcon, size: 20, color: AppColors.primaryColor)
                  : Image.asset(suffixAssetIcon!),
              border: InputBorder.none,
              hintText: hintText,
              hintStyle:
                  AppTypography.s18w500.copyWith(color: AppColors.f67Color),
            ),
            style: AppTypography.s18w500.copyWith(color: AppColors.blackColor),
            onChanged: onChanged,
            readOnly: readOnly!,
            onTap: onTap
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(
              height: 4), // khoảng cách nhỏ giữa TextField và errorText
          Text(
            errorText!,
            style: AppTypography.s14w500.copyWith(color: AppColors.errorColor),
          ),
        ],
      ],
    );
  }
}
