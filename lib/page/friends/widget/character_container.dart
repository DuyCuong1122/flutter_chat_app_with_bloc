import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:flutter/material.dart';

class CharacterContainer extends StatelessWidget {
  final String character;
  const CharacterContainer({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 4, 0, 4),
      color: AppColor.f6Color,
      child: Text(
        character.toUpperCase(),
        style: AppTypography.s16w800,
      ),
    );
  }
}
