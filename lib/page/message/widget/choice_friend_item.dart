import 'package:chat_app/bloc/check_box/check_box_bloc.dart';
import 'package:chat_app/bloc/check_box/check_box_state.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/common/widgets/default_avatar.dart';
import 'package:chat_app/database/models/model.dart';
import 'package:chat_app/page/message/widget/custom_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/check_box/check_box_event.dart';

class ChoiceFriendItem extends StatelessWidget {
  final User user;
  const ChoiceFriendItem({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.read<CheckBoxBloc>().add(CheckBoxToggleEvent(item: user)),
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const DefaultAvatar(size: 35),
            const SizedBox(width: 12),
            Text(
              user.name!,
              style: AppTypography.s16w800.copyWith(color: Colors.black),
            ),
            const Spacer(),
            CustomCheckbox(user: user),
          ],
        ),
      ),
    );
  }
}
