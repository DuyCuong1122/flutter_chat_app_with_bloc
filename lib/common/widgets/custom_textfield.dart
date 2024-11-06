import 'package:chat_app/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {

  final String labelText;
  final IconData suffixIcon;
  final TextEditingController controller;
  final bool ispassword;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.suffixIcon,
    required this.controller,
    this.ispassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          labelStyle: GoogleFonts.lato(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: const Color(0xFF999999),
          ),
          suffixIcon: Icon(suffixIcon, size: 16, color: AppColor.primaryColor,),
          border: InputBorder.none,
          // contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
        style: GoogleFonts.lato(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.black,
          ),
      ),
    );
  }
}
