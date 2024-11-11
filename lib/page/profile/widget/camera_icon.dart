import 'package:chat_app/common/values/colors.dart';
import 'package:flutter/material.dart';

class CameraIcon extends StatelessWidget {
  final double size;
  const CameraIcon({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor,
          border: Border.all(
            color: Colors.white,
            width: size*0.075,
          ),
        ),
        child: Icon(
          Icons.camera_alt,
          color: Colors.white,
          size: size / 2,
        ),
      ),
    );
  }
}
