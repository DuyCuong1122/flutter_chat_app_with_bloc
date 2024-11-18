import 'package:flutter/material.dart';

import '../values/colors.dart';
import '../values/icons.dart';

class DefaultAvatar extends StatelessWidget {
  final double size;

  const DefaultAvatar({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
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
      child:  Icon(
        AppIcon.person,
        color: Colors.white,
        size: size /1.5,
      ),
    );
  }
}
