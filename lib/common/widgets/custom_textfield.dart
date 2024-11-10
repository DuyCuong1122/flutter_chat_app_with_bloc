import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData suffixIcon;
  final TextEditingController controller;
  final bool ispassword;
  final String? errorText;
  final void Function(String)? onChanged;
  final String? hintText;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.suffixIcon,
    required this.controller,
    this.ispassword = false,
    this.onChanged,
    this.errorText,
    this.hintText,
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
                  AppTypography.s14w500.copyWith(color: AppColor.normalColor),
              suffixIcon: Icon(
                suffixIcon,
                size: 20,
                color: AppColor.primaryColor,
              ),
              border: InputBorder.none,
              hintText: hintText,
              hintStyle:
                  AppTypography.s18w500.copyWith(color: AppColor.f67Color),
            ),
            style: AppTypography.s18w500.copyWith(color: AppColor.blackColor),
            onChanged: onChanged,
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(
              height: 4), // khoảng cách nhỏ giữa TextField và errorText
          Text(
            errorText!,
            style: AppTypography.s14w500.copyWith(color: AppColor.errorColor),
          ),
        ],
      ],
    );
  }
}
