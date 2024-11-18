import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/check_box/check_box_bloc.dart';
import '../../../common/values/colors.dart';
import '../../../database/models/user.dart';

class CustomCheckbox extends StatelessWidget {
  final User user;

  const CustomCheckbox({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final value = context.watch<CheckBoxBloc>().users.contains(user);
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: value ? AppColors.primaryColor : const Color(0xFF989898),
            width: 1.5),
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
