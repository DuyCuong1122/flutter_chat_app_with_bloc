import 'dart:async';
import 'dart:developer';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/storage.dart';
import 'package:chat_app/common/widgets/custom_background.dart';
import 'package:chat_app/database/services/service.dart';
import 'package:chat_app/page/homepage.dart';
import 'package:chat_app/page/log_in/log_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/message/message_bloc.dart';
import '../bloc/request/request_bloc.dart';
import '../bloc/request_action/request_action_bloc.dart';

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
        MaterialPageRoute(
            builder: (context) =>
                SharedPreferencesService().getBool(IS_LOGIN) == true
                    ? const Homepage()
                    : const LogInView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    log('login ${SharedPreferencesService().getBool(IS_LOGIN)}');
    return Scaffold(
        body: CustomBackground(
          ratio: 1,
          child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 4),
              child: Center(
                child: Column(
                  children: [
                    Image.asset(AppIcon.splashPNG),
                    RichText(
                        text: TextSpan(
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
