import 'package:chat_app/common/values/typography.dart';
import 'package:flutter/material.dart';

class NotificationCircleContainer extends StatelessWidget {
  final int number;
  final double size;

  const NotificationCircleContainer(
      {super.key, required this.number, required this.size});

  @override
  Widget build(BuildContext context) {
    if (number > 0) {
      return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
          border: Border.all(
            color: Colors.white,
            width: 0.5,
          ),
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: AppTypography.s12w800,
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
