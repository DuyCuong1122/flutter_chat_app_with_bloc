import 'dart:async';

import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/page/log_in/log_in_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LogInView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.primaryColor, AppColor.secondaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/4), child: Center(
          child: Column(
            children:  [
              Image.asset(AppIcon.splashPNG),
              RichText(text:  TextSpan(
                text: 'Awesome ',
                style: GoogleFonts.exo(
                  textStyle: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                children: [
                  TextSpan(
                    text: 'chat',
                    style: GoogleFonts.exo(
                  textStyle: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                  ),
                ],
              )),
            ],
          ),
        )),
    ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Center(
        child: Text(
          'This is the Home Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
