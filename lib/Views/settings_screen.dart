import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_player/constants/colors.dart';
import 'package:music_player/constants/textstyles.dart';
import 'package:music_player/controllers/themeController.dart';
import 'package:music_player/widgets/threedotMenu.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isLight = themeController.isLight.value;
      return Scaffold(

      backgroundColor: AppColors.backgroundColor(isLight),
        appBar: AppBar(backgroundColor: AppColors.backgroundColor(isLight),
        automaticallyImplyLeading: false,
        leading:      ThreeDotMenu(
          theme: isLight,
          color: AppColors.primaryColor(isLight),
        )),
        body: Column(
          children: [
            SizedBox(height: 30.sp),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 17),
              height: 70.sp,
              decoration: BoxDecoration(
                  color: AppColors.tileColor(isLight),
                  borderRadius: BorderRadius.circular(18)
              ),
              child: Row(
                children: [
                  Switch(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    value: !isLight,
                    splashRadius: 5,
                    activeColor: AppColors.darkShadow(!isLight),
                    activeTrackColor: AppColors.primaryColor(isLight),
                    inactiveThumbColor: AppColors.darkShadow(!isLight),
                    onChanged: (value) {
                      themeController.toggleTheme();
                    },
                  ),
                  Text("Enable Dark Mode ",style: primaryTextStyle(color: isLight? Colors.black: Colors.white),)
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
