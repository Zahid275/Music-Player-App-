import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:music_player/Views/home_screen.dart';

import '../Views/about_screen.dart';
import '../Views/settings_screen.dart';
import '../constants/textstyles.dart';

class MyDrawer extends StatelessWidget {
  final bool isLight;
  final Color drawerColor;

  const MyDrawer({super.key, required this.isLight, required this.drawerColor});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: drawerColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(height: 60.sp),

          TextButton(
            onPressed: () {
              Get.to(() => HomeScreen());
            },
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.house,
                  color: isLight ? Colors.grey.shade500 : Colors.grey.shade300,
                  size: 27,
                ),
                SizedBox(width: 20.sp),
                Text(
                  "Home ",
                  style: primaryTextStyle(
                    size: 24,
                    color: isLight ? Colors.black : Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.sp),

          TextButton(
            onPressed: () {
              Get.to(() => SettingsScreen());
            },
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.gear,
                  color: isLight ? Colors.grey.shade500 : Colors.grey.shade300,
                  size: 27,
                ),
                SizedBox(width: 20.sp),
                Text(
                  "Setting ",
                  style: primaryTextStyle(
                    size: 24,
                    color: isLight ? Colors.black : Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.sp),

          TextButton(
            onPressed: () {
              Get.to(() => AboutScreen());
            },
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.circleInfo,
                  color: isLight ? Colors.grey.shade500 : Colors.grey.shade300,
                  size: 27,
                ),
                SizedBox(width: 20.sp),
                Text(
                  "About ",
                  style: primaryTextStyle(
                    size: 24,
                    color: isLight ? Colors.black : Colors.white,
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
