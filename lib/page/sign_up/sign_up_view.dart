import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/common/widgets/custom_container_sign_in_out.dart';
import 'package:chat_app/common/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  // Tạo biến lưu trạng thái cho các tùy chọn Checkbox
  bool accept = false;

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
                  SizedBox(height: heightScreen * 0.08),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        AppIcon.back,
                        size: 30,
                        color: AppColor.primaryColor,
                      )),
                  SizedBox(height: heightScreen * 0.06),
                  Text(AppLocalizations.of(context)!.register,
                      style: AppTypography.signInUpTitle),
                  SizedBox(height: heightScreen * 0.08),
                  CustomTextField(
                    controller: TextEditingController(),
                    labelText: AppLocalizations.of(context)!.fullName,
                    suffixIcon: AppIcon.person,
                  ),
                  SizedBox(height: heightScreen / 20),
                  CustomTextField(
                    controller: TextEditingController(),
                    labelText: 'email',
                    suffixIcon: AppIcon.mail,
                  ),
                  SizedBox(height: heightScreen / 20),
                  CustomTextField(
                    controller: TextEditingController(),
                    labelText: AppLocalizations.of(context)!.password,
                    suffixIcon: AppIcon.key,
                    ispassword: true,
                  ),
                  SizedBox(height: heightScreen * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            accept = !accept;
                          });
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColor.primaryColor, width: 2),
                            color:
                                accept ? AppColor.primaryColor : Colors.white,
                          ),
                          child: accept
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: RichText(
                            text: TextSpan(
                          text: '${AppLocalizations.of(context)!.iAgreeTo} ',
                          style: AppTypography.s14w500
                              .copyWith(color: AppColor.normalColor),
                          children: [
                            TextSpan(
                              text:
                                  '${AppLocalizations.of(context)!.policies} ',
                              style: AppTypography.s14w700,
                            ),
                            TextSpan(
                              text: '${AppLocalizations.of(context)!.and} ',
                              style: AppTypography.s14w500
                                  .copyWith(color: AppColor.normalColor),
                            ),
                            TextSpan(
                              text: AppLocalizations.of(context)!.terms,
                              style: AppTypography.s14w700,
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                  SizedBox(height: heightScreen * 0.06),
                  CustomContainerSignInOut(
                    title: AppLocalizations.of(context)!.register,
                    onTap: () {},
                    enable: true,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.alreadyHaveAnAcount}? ',
                        style: AppTypography.s14w500
                            .copyWith(color: AppColor.normalColor),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.logInNow,
                          style: AppTypography.s14w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: heightScreen / 20),
                ],
              ))),
    );
  }
}
