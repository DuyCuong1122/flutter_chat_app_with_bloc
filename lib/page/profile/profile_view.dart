import 'package:chat_app/bloc/auth/auth_bloc.dart';
import 'package:chat_app/bloc/auth/auth_event.dart';
import 'package:chat_app/bloc/auth/auth_state.dart';
import 'package:chat_app/bloc/locale/locale_cubit.dart';
import 'package:chat_app/common/widgets/custom_background.dart';
import 'package:chat_app/common/widgets/default_avatar.dart';
import 'package:chat_app/database/services/service.dart';
import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/storage.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/page/log_in/log_in_view.dart';
import 'package:chat_app/page/profile/screen/edit_info_screen.dart';
import 'package:chat_app/page/profile/widget/profile_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;
    final translate = AppLocalizations.of(context)!;
    final currentLocale = context.read<LocaleCubit>();
    return Scaffold(
      body: Stack(
        children: [
          CustomBackground(
            ratio: 0.64,
            child: Icon(
              AppIcon.person,
              size: widthScreen,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  decoration:  const BoxDecoration(
                    color: AppColors.fefeeColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: heightScreen * 0.14,
                        color: Colors.white,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const DefaultAvatar(size: 63),
                                const SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      SharedPreferencesService()
                                          .getString(NAME),
                                      style: AppTypography.s22w700.copyWith(
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      SharedPreferencesService()
                                          .getString(EMAIL),
                                      style: AppTypography.s16w500.copyWith(
                                        color: AppColors.f99Color,
                                      ),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const EditInfoScreen()));
                                  },
                                  icon: const Icon(
                                    AppIcon.edit,
                                    color: AppColors.primaryColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Builder(builder: (
                        context,
                      ) {
                        return ProfileCustomButton(
                            icon: AppIcon.language,
                            text: translate.language,
                            suffixIcon: true,
                            onTap: () => currentLocale
                                        .currentLocale.languageCode ==
                                    'en'
                                ? currentLocale.setLocale(const Locale('vi'))
                                : currentLocale.setLocale(const Locale('en')),
                            isLogout: false,
                            isVersion: false,
                            subtile:
                                currentLocale.currentLocale.languageCode == 'en'
                                    ? 'English'
                                    : 'Tiếng Việt');
                      }),
                      const Padding(
                          padding: EdgeInsets.only(left: 54, right: 12),
                          child: Divider(
                            height: 0.5,
                            color: Color(0xFFD2D2D2),
                          )),
                      ProfileCustomButton(
                          icon: AppIcon.noti,
                          text: translate.notification,
                          suffixIcon: true,
                          onTap: () {},
                          isLogout: false,
                          isVersion: false),
                      const Padding(
                          padding: EdgeInsets.only(left: 54, right: 12),
                          child: Divider(
                            height: 0.5,
                            color: Color(0xFFD2D2D2),
                          )),
                      ProfileCustomButton(
                          icon: AppIcon.version,
                          text: translate.appVersion,
                          suffixIcon: false,
                          onTap: () {},
                          isLogout: false,
                          isVersion: true,
                          subtile: '1.0.0'),
                      const SizedBox(
                        height: 5,
                      ),
                      BlocListener(
                        bloc: context.read<AuthBloc>(),
                        listener: (context, state) {
                          if (state is AuthLoading) {
                            EasyLoading.show(
                                maskType: EasyLoadingMaskType.black);
                          } else if (state is AuthLogout) {
                            EasyLoading.dismiss();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LogInView()));
                          }
                        },
                        child: ProfileCustomButton(
                            icon: AppIcon.logout,
                            text: translate.logout,
                            suffixIcon: false,
                            onTap: () => context
                                .read<AuthBloc>()
                                .add(AuthLogoutRequested()),
                            isLogout: true,
                            isVersion: false),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
