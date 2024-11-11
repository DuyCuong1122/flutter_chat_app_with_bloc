import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/common/widgets/custom_textfield.dart';
import 'package:chat_app/page/profile/widget/bubble_container.dart';
import 'package:chat_app/page/profile/widget/camera_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditInfoScreen extends StatefulWidget {
  const EditInfoScreen({super.key});

  @override
  State<EditInfoScreen> createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen> {
  late TextEditingController fullNameController;
  late TextEditingController phoneController;
  late TextEditingController birthdayController;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    phoneController = TextEditingController();
    birthdayController = TextEditingController();
    selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    birthdayController.dispose();
    super.dispose();
  }
Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Ngày mặc định
      firstDate: DateTime(2000), // Ngày bắt đầu
      lastDate: DateTime(2100),  // Ngày kết thúc
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        birthdayController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }


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
                        ),
                      ),
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
                      ),
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
                            SizedBox(height: heightScreen * 0.05),
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
                            SizedBox(height: heightScreen * 0.054),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                children: [
                                  CustomTextField(
                                    labelText: translate.fullName,
                                    suffixIcon: AppIcon.person,
                                    controller: fullNameController,
                                  ),
                                  SizedBox(height: heightScreen * 0.04),
                                  CustomTextField(
                                    labelText: translate.phone,
                                    suffixAssetIcon: AppIcon.phone,
                                    controller: phoneController,
                                  ),
                                  SizedBox(height: heightScreen * 0.04),
                                  CustomTextField(
                                    labelText: translate.dateOfBirth,
                                    suffixAssetIcon: AppIcon.birthday,
                                    controller: birthdayController,
                                    readOnly: true,
                                    onTap: () => _selectDate(context),
                                  ),
                                ],
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
                          left: widthScreen * 0.819,
                          top: heightScreen * 0.05,
                          child: BubbleContainer(size: 0.048 * widthScreen),
                        ),
                        Positioned(
                          left: widthScreen * 0.883,
                          top: heightScreen * 0.16,
                          child: BubbleContainer(size: 0.051 * widthScreen),
                        ),
                        Positioned(
                          left: widthScreen * 0.067,
                          top: heightScreen * 0.1,
                          child: BubbleContainer(size: 0.029 * widthScreen),
                        ),
                        Positioned(
                          left: widthScreen * 0.2,
                          top: heightScreen * 0.14,
                          child: BubbleContainer(size: 0.043 * widthScreen),
                        ),
                        Positioned(
                          left: widthScreen * 0.043,
                          top: heightScreen * 0.176,
                          child: BubbleContainer(size: 0.035 * widthScreen),
                        ),
                        Positioned(
                          left: widthScreen * 0.57,
                          top: heightScreen * 0.183,
                          child: CameraIcon(size: 0.107 * widthScreen),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
