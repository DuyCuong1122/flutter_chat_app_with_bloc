import 'package:flutter/material.dart';

class BubbleContainer extends StatelessWidget {
  final double size;
  const BubbleContainer({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xFFF7FBFF),
              Color(0xFFDAEEFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
    );
  }
}
