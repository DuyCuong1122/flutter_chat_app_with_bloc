import 'dart:developer';

import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }



  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double tabWidth =
        MediaQuery.of(context).size.width / 3; // Chiều rộng của mỗi tab
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: const [
          Center(child: Text("Home Page")),
          Center(child: Text("Search Page")),
          Center(child: Text("Profile Page")),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0), // Khoảng cách xung quanh
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Màu nền của container
            borderRadius: BorderRadius.circular(24), // Bo góc
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Màu đổ bóng
                spreadRadius: 1, // Độ lan rộng của bóng
                blurRadius: 10, // Độ mờ của bóng
                offset: const Offset(0, 5), // Vị trí bóng đổ
              ),
            ],
          ),
          child: Stack(
            children: [
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.transparent, // Tắt màu nền khi chọn tab
                labelColor: AppColor.primaryColor,
                unselectedLabelColor: AppColor.greyColor,
                tabs: [
                  Tab(
                    icon:  Icon(AppIcon.message),
                    text: AppLocalizations.of(context)!.message,
                  ),
                  Tab(
                    icon: const Icon(AppIcon.friend),
                    text: AppLocalizations.of(context)!.friends,
                  ),
                  Tab(
                    icon: const Icon(AppIcon.profile),
                    text: AppLocalizations.of(context)!.profile,
                  ),
                ],
              ),
              // Vòng tròn di chuyển theo tab được chọn
              // AnimatedPositioned(
              //   duration: const Duration(milliseconds: 300),
              //   curve: Curves.easeInOut,
              //   top: 0, // Đặt vòng tròn lên trên đầu của Tab
              //   left: _tabController.index * tabWidth +
              //       tabWidth / 2 -
              //       8, // Căn giữa vòng tròn trên tab
              //   child: Container(
              //     width: 8, // Kích thước vòng tròn
              //     height: 8,
              //     decoration: const BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: AppColor.primaryColor,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
