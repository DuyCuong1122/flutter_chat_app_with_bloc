import 'package:flutter/material.dart';

import '../values/colors.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;
  const CustomCheckBox({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primaryColor, width: 2),
        color: value ? AppColors.primaryColor : Colors.white,
      ),
      child: value
          ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            )
          : null,
    );
  }
}
