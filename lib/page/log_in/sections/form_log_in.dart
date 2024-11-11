import 'package:chat_app/bloc/auth/auth_bloc.dart';
import 'package:chat_app/bloc/auth/auth_event.dart';
import 'package:chat_app/bloc/auth/auth_state.dart';
import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/common/widgets/custom_container_sign_in_out.dart';
import 'package:chat_app/common/widgets/custom_textfield.dart';
import 'package:chat_app/page/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormLogIn extends StatefulWidget {
  const FormLogIn({super.key});

  @override
  State<FormLogIn> createState() => _FormLogInState();
}

class _FormLogInState extends State<FormLogIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  static const emailPattern = r'^[a-zA-Z0-9._%+-]+@gmail\.com$';
  static const passwordPattern =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,}$';

  void validateEmail(String value) {
    setState(() {
      emailError = value.isEmpty
          ? AppLocalizations.of(context)!.emptyEmail
          : !RegExp(emailPattern).hasMatch(value)
              ? "*${AppLocalizations.of(context)!.invalidEmailFormat}"
              : null;
    });
  }

  void validatePassword(String value) {
    setState(() {
      passwordError = value.isEmpty
          ? AppLocalizations.of(context)!.emptyPassword
          : !RegExp(passwordPattern).hasMatch(value)
              ? AppLocalizations.of(context)!.invalidPasswordFormat
              : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final localizations = AppLocalizations.of(context)!;

    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: AppColors.errorColor,
              content: Text(state.message),
            ));
          } else if (state is AuthAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: AppColors.successColor,
              content: Text(localizations.succussSignIn),
            ));
            EasyLoading.dismiss();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Homepage()),
            );
          } else if (state is AuthLoading) {
            EasyLoading.show(maskType: EasyLoadingMaskType.black);
          }
        },
        child: Column(
          children: [
            CustomTextField(
              controller: emailController,
              labelText: 'email',
              suffixIcon: AppIcon.mail,
              onChanged: validateEmail,
              errorText: emailError,
              hintText: "yourname@gmail.com",
            ),
            SizedBox(height: heightScreen / 20),
            CustomTextField(
              controller: passwordController,
              labelText: AppLocalizations.of(context)!.password,
              suffixIcon: AppIcon.key,
              ispassword: true,
              onChanged: validatePassword,
              errorText: passwordError,
            ),
            SizedBox(height: heightScreen / 80),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  '${localizations.forgotPassword}?',
                  style: AppTypography.s14w700,
                ),
              ),
            ),
            SizedBox(height: heightScreen / 20),
            CustomContainerSignInOut(
              title: localizations.logIn,
              onTap: () {
                FocusScope.of(context).unfocus();
                if (emailError == null && passwordError == null) {
                  context.read<AuthBloc>().add(AuthLoginRequested(
                        email: emailController.text,
                        password: passwordController.text,
                      ));
                }
              },
              enable: emailError == null && passwordError == null,
            ),
          ],
        ));
  }
}
