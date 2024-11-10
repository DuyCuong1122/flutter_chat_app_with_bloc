import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/common/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FriendView extends StatelessWidget {
  const FriendView({super.key});

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: heightScreen * 0.28,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    AppColors.primaryColor,
                    AppColors.secondaryColor,
                  ])),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      SizedBox(height: heightScreen * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.friends,
                            style: AppTypography.s30w700.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Image.asset(AppIcon.addFriend),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: heightScreen * 0.03),
                      CustomSearchBar(
                        controller: TextEditingController(),
                        hintText:
                            '${AppLocalizations.of(context)!.searchFriends}...',
                        onSearch: (String query) {},
                      ),
                      SizedBox(height: heightScreen * 0.03),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: DefaultTabController(
                        length: 3,
                        child: Column(
                          children: [
                            TabBar(
                              indicatorColor: AppColors.primaryColor,
                              labelColor: AppColors.primaryColor,
                              unselectedLabelColor: AppColors.normalColor,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              tabs: [
                                Tab(
                                    text: AppLocalizations.of(context)!
                                        .friends
                                        .toUpperCase()),
                                Tab(
                                    text: AppLocalizations.of(context)!
                                        .all
                                        .toUpperCase()),
                                Tab(
                                    text: AppLocalizations.of(context)!
                                        .request
                                        .toUpperCase()),
                              ],
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: 23),
                                child: TabBarView(
                                  children: [
                                    Center(child: Text("All Friends Content")),
                                    Center(child: Text("Requests Content")),
                                    Center(child: Text("Blocked Content")),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
