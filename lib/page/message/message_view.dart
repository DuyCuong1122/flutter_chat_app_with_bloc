import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/common/widgets/custom_search_bar.dart';
import 'package:chat_app/page/message/widget/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

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
                    AppColor.primaryColor,
                    AppColor.secondaryColor,
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
                            AppLocalizations.of(context)!.message,
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
                              child: Image.asset(AppIcon.newMessage),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: heightScreen * 0.03),
                      CustomSearchBar(
                        controller: TextEditingController(),
                        hintText:
                            '${AppLocalizations.of(context)!.searchMessage}...',
                        onSearch: (String query) {},
                      ),
                      SizedBox(height: heightScreen * 0.03),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: ListView.builder(
                        itemCount: 50,
                        itemBuilder: (context, index) {
                          return MessageItem(
                            message: index.toString(),
                            name: index.toString(),
                            time: index.toString(),
                            newMessageCount: index,
                          );
                        }),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
