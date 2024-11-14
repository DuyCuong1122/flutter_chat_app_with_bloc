import 'package:chat_app/common/values/typography.dart';
import 'package:flutter/material.dart';

class NotificationCircleContainer extends StatelessWidget {
  final int number;
  const NotificationCircleContainer({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 23,
      width: 23,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: AppTypography.s12w800,
        ),
      ),
    );
  }
}