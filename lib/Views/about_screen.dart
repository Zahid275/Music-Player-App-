import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/constants/colors.dart';
import 'package:music_player/widgets/threedotMenu.dart';

import '../constants/textstyles.dart';
import '../controllers/themeController.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});

  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isLight = themeController.isLight.value;

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,

          leading:      ThreeDotMenu(
            theme: isLight,
            color: AppColors.primaryColor(isLight),
          ),
          title: const Text('🎵 About Melodia'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            // scrollable if needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🎧 Melodia',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Melodia is a beautiful music player app 🎶 built to enhance Flutter skills. '
                  'It allows you to play, pause ⏯️, skip next ⏭️, and previous ⏮️ songs. '
                  'Mark songs as favorites ❤️ which are stored in local storage using Hive 🐝 '
                  'Music keeps playing even when the app is closed or screen is off 🔒. '
                  'Song info also appears in notifications 🔔.'
                  'Switch between Light 🌞 and Dark 🌙 modes for a better user experience'
                ),
                SizedBox(height: 20),
                Text(
                  '🛠️ Built With:',
                  style: primaryTextStyle(fontweight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text(
                  '- Flutter 💙\n- GetX ⚡\n- Hive 🐝\n- MVC Architecture 🧱',
                ),
                SizedBox(height: 20),
                Text(
                  '👨‍💻 Developer:',
                  style: primaryTextStyle(fontweight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text('Zahid Rasheed'),
                SizedBox(height: 20),
                Text(
                  '🎨 Theme Support:',
                  style: primaryTextStyle(fontweight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text('Melodia supports both Light 🌞 and Dark 🌙 modes.'),
              ],
            ),
          ),
        ),
      );
    });
  }
}
