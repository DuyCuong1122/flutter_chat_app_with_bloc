import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/page/message/message_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  int myCurrentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List pages = const [
      MessageView(),
      Center(child: Text("Search Page")),
      Center(child: Text("Profile Page")),
    ];

    return Scaffold(
      body: pages[myCurrentIndex],
        bottomNavigationBar: Container(
      height: 70,
      margin: const EdgeInsets.only(bottom: 16, left: 12, right: 12, top: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BottomNavigationBar(
          currentIndex: myCurrentIndex,
          backgroundColor: Colors.white,
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: AppColor.normalColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items:  [
            BottomNavigationBarItem(
              icon: Image.asset(AppIcon.message, color: myCurrentIndex == 0 ? AppColor.primaryColor : AppColor.normalColor,),
              label: AppLocalizations.of(context)!.message,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(AppIcon.friend, color: myCurrentIndex == 1 ? AppColor.primaryColor : AppColor.normalColor,),
              label: AppLocalizations.of(context)!.friends,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(AppIcon.profile, color: myCurrentIndex == 2 ? AppColor.primaryColor : AppColor.normalColor,),
              label: AppLocalizations.of(context)!.profile,
            ),
          ],
          onTap: (index) {
            setState(() {
              myCurrentIndex = index;
            });
          },
        ),
      ),
    ));
  }
}
