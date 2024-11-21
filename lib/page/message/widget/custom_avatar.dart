import 'package:chat_app/bloc/auth/auth_bloc.dart';
import 'package:chat_app/bloc/check_box/check_box_bloc.dart';
import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/widgets/default_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/check_box/check_box_event.dart';
import '../../../database/models/user.dart';

class CustomAvatar extends StatelessWidget {
  final User user;
  const CustomAvatar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const DefaultAvatar(size: 58),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => context
                .read<CheckBoxBloc>()
                .add(CheckBoxToggleEvent(item: user)),
            child: Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child:  const Icon(
                Icons.close,
                color: AppColors.primaryColor,
                size: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
