import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/page/profile/widget/bubble_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditInfoScreen extends StatelessWidget {
  const EditInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: heightScreen * 0.28,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor,
                    AppColors.secondaryColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: heightScreen * 0.08),
                Padding(
                  padding: const EdgeInsets.only(left: 7, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            AppIcon.back,
                            color: AppColors.whiteColor,
                            size: 24,
                          )),
                      Text(
                        translate.editInfo,
                        style: AppTypography.s18w800.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          translate.save,
                          style: AppTypography.s16w500.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: heightScreen * 0.04),
                Expanded(
                    child: Container(
                        width: widthScreen,
                        decoration: const BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: heightScreen * 0.05,
                                ),
                                Center(
                                  child: Container(
                                    height: widthScreen * 0.38,
                                    width: widthScreen * 0.38,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.primaryColor,
                                          AppColors.secondaryColor,
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    child: Icon(
                                      AppIcon.person,
                                      color: Colors.white,
                                      size: widthScreen * 0.25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              left: widthScreen * 0.197,
                              top: heightScreen * 0.0468,
                              child: BubbleContainer(size: 0.061 * widthScreen),
                            ),
                            Positioned(
                              left: widthScreen * 0.197,
                              top: heightScreen * 0.0468,
                              child: BubbleContainer(size: 0.061 * widthScreen),
                            ),
                          ],
                        )))
              ],
            )
          ],
        ),
      ),
    );
  }
}
