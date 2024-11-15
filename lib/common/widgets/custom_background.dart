import 'package:flutter/material.dart';

import '../values/colors.dart';

class CustomBackground extends StatelessWidget {
  final double ratio;
  final Widget? child;
  const CustomBackground({super.key,  this.ratio = 0.28, this.child});

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    return Container(
      height: heightScreen * ratio,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primaryColor,
                AppColors.secondaryColor,
              ])),
      child: child,
    );
  }
}
