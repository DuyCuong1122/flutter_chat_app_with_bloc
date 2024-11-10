import 'package:chat_app/bloc/auth/auth_bloc.dart';
import 'package:chat_app/bloc/auth/auth_event.dart';
import 'package:chat_app/bloc/auth/auth_state.dart';
import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/common/widgets/custom_container_sign_in_out.dart';
import 'package:chat_app/common/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool accept = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  String? emailError;
  String? passwordError;
  String? nameError;

  void validateEmail(String value) {
    setState(() {
      emailError = value.isEmpty
          ? AppLocalizations.of(context)!.emptyEmail
          : !RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$').hasMatch(value)
              ? "*${AppLocalizations.of(context)!.invalidEmailFormat}"
              : null;
    });
  }

  void validatePassword(String value) {
    setState(() {
      passwordError = value.isEmpty
          ? AppLocalizations.of(context)!.emptyPassword
          : !RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,}$')
                  .hasMatch(value)
              ? AppLocalizations.of(context)!.invalidPasswordFormat
              : null;
    });
  }

  void validateName(String value) {
    setState(() {
      nameError = value.isEmpty
          ? AppLocalizations.of(context)!.emptyName
          : !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)
              ? "*${AppLocalizations.of(context)!.invalidName}"
              : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: AppColor.errorColor,
                  content: Text(state.message),
                ));
              } else if (state is AuthAuthenticated) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: AppColor.successColor,
                  content: Text(AppLocalizations.of(context)!.successSignUp),
                ));
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: heightScreen * 0.08),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          AppIcon.back,
                          size: 30,
                          color: AppColor.primaryColor,
                        ),
                      ),
                      SizedBox(height: heightScreen * 0.05),
                      Text(AppLocalizations.of(context)!.register,
                          style: AppTypography.signInUpTitle),
                      SizedBox(height: heightScreen * 0.07),
                      CustomTextField(
                        controller: nameController,
                        labelText: AppLocalizations.of(context)!.fullName,
                        suffixIcon: AppIcon.person,
                        onChanged: validateName,
                        errorText: nameError,
                      ),
                      SizedBox(height: heightScreen * 0.04),
                      CustomTextField(
                        controller: emailController,
                        labelText: 'email',
                        suffixIcon: AppIcon.mail,
                        onChanged: validateEmail,
                        errorText: emailError,
                      ),
                      SizedBox(height: heightScreen * 0.04),
                      CustomTextField(
                        controller: passwordController,
                        labelText: AppLocalizations.of(context)!.password,
                        suffixIcon: AppIcon.key,
                        ispassword: true,
                        onChanged: validatePassword,
                        errorText: passwordError,
                      ),
                      SizedBox(height: heightScreen * 0.04),
                      Row(
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
                                color: accept
                                    ? AppColor.primaryColor
                                    : Colors.white,
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
                              text:
                                  '${AppLocalizations.of(context)!.iAgreeTo} ',
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
                      SizedBox(height: heightScreen * 0.05),
                      CustomContainerSignInOut(
                        title: AppLocalizations.of(context)!.register,
                        onTap: () {
                          if (emailError == null &&
                              passwordError == null &&
                              nameError == null &&
                              accept) {
                            context.read<AuthBloc>().add(AuthSignUpRequested(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ));
                          }
                        },
                        enable: emailError == null &&
                            passwordError == null &&
                            nameError == null &&
                            accept,
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
                      SizedBox(height: heightScreen * 0.04),
                    ],
                  ));
            },
          )),
    );
  }
}
