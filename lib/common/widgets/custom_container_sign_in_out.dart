import 'package:chat_app/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomContainerSignInOut extends StatelessWidget {
  final bool enable;
  final String title;
  final VoidCallback onTap;

  const CustomContainerSignInOut({
    super.key,
    required this.enable,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enable ? onTap : null,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: enable ? AppColors.primaryColor : AppColors.unableColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            title.toUpperCase(),
            style:GoogleFonts.lato(
              textStyle: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
