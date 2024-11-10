import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/page/log_in/sections/form_log_in.dart';
import 'package:chat_app/page/sign_up/sign_up_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final heightScreen = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: heightScreen * 0.1),
              Image.asset(
                AppIcon.loginPNG,
              ),
              Text(localizations.enjoyAwesomeChat,
                  style: GoogleFonts.lato(
                      fontSize: 26,
                      fontWeight: FontWeight.w300,
                      color: Colors.black)),
              SizedBox(height: heightScreen / 80),
              Text(localizations.logIn, style: AppTypography.signInUpTitle),
              SizedBox(height: heightScreen * 6 / 80),
              const FormLogIn(),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${localizations.noAccount}? ',
                    style: AppTypography.s14w500
                        .copyWith(color: AppColor.unableColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpView()));
                    },
                    child: Text(
                      localizations.registerNow,
                      style: AppTypography.s14w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: heightScreen * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
