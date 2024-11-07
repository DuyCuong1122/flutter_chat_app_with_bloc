import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/common/widgets/custom_textfield.dart';
import 'package:chat_app/page/homepage.dart';
import 'package:chat_app/page/sign_up/sign_up_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/widgets/custom_container_sign_in_out.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: heightScreen / 10),
              Image.asset(
                AppIcon.loginPNG,
              ),
              Text(AppLocalizations.of(context)!.enjoyAwesomeChat,
                  style: GoogleFonts.lato(
                      fontSize: 26,
                      fontWeight: FontWeight.w300,
                      color: Colors.black)),
              SizedBox(height: heightScreen / 80),
              Text(AppLocalizations.of(context)!.logIn,
                  style: AppTypography.signInUpTitle),
              SizedBox(height: heightScreen * 6 / 80),
              CustomTextField(
                controller: TextEditingController(),
                labelText: 'email',
                suffixIcon: AppIcon.mail,
              ),
              SizedBox(height: heightScreen / 20),
              CustomTextField(
                controller: TextEditingController(),
                labelText: 'password',
                suffixIcon: AppIcon.key,
                ispassword: true,
              ),
              SizedBox(height: heightScreen / 80),
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
              SizedBox(height: heightScreen / 20),
              CustomContainerSignInOut(
                title: AppLocalizations.of(context)!.logIn,
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Homepage()));
                },
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpView()));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.registerNow,
                      style: AppTypography.s14w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: heightScreen / 20),
            ],
          ),
        ),
      ),
    );
  }
}
