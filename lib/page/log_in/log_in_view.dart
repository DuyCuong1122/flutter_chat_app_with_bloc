import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/common/widgets/custom_textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/widgets/custom_container_sign_in_out.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 80, 24, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppIcon.loginPNG,
              ),
              Text(AppLocalizations.of(context)!.enjoyAwesomeChat,
                  style: GoogleFonts.lato(
                      fontSize: 26,
                      fontWeight: FontWeight.w300,
                      color: Colors.black)),
              const SizedBox(height: 10),
              Text(AppLocalizations.of(context)!.logIn,
                  style: AppTypography.signInUpTitle),
              const SizedBox(height: 60),
              CustomTextField(
                controller: TextEditingController(),
                labelText: 'email',
                suffixIcon: AppIcon.mail,
              ),
              const SizedBox(height: 40),
              CustomTextField(
                controller: TextEditingController(),
                labelText: 'password',
                suffixIcon: AppIcon.key,
                ispassword: true,
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    '${AppLocalizations.of(context)!.forgotPassword}?',
                    style: AppTypography.s14w700,
                  ),
                ),
              ),
              const SizedBox(height: 45),
              CustomContainerSignInOut(
                title: AppLocalizations.of(context)!.logIn,
                onTap: () {},
                enable: true,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.noAccount}? ',
                    style: AppTypography.s14w500
                        .copyWith(color: AppColor.unableColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, '/sign_up');
                    },
                    child: Text(
                      AppLocalizations.of(context)!.registerNow,
                      style: AppTypography.s14w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
