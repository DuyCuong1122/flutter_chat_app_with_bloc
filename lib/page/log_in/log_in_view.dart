import 'dart:developer';

import 'package:chat_app/common/widgets/custom_container_sign_in_out.dart';
import 'package:flutter/material.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 80, 24, 40),
        child: CustomContainerSignInOut(enable: true, title: 'Dang nhap', onTap: () {log('debugShowCheckedModeBanner');}),
      ),
    );
  }
}
