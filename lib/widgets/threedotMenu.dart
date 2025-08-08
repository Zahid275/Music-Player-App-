import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:music_player/Views/about_screen.dart';
import 'package:music_player/Views/home_screen.dart';
import 'package:music_player/Views/settings_screen.dart';
import 'package:music_player/widgets/threed_dot_menuI_tem.dart';


class ThreeDotMenu extends StatelessWidget {
  final bool theme;
  final Color color;

  const ThreeDotMenu({super.key, required this.theme, required this.color});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context){
        return[
          PopupMenuItem(child: threeDotMenu_Item(theme: theme, label: "Home",icon: FontAwesomeIcons.house,onTap:(){Get.to(() => (HomeScreen()));}        )),
          PopupMenuItem(child: threeDotMenu_Item(theme: theme, label: "Setting",icon: FontAwesomeIcons.gear,onTap:(){Get.to(() => (SettingsScreen()));}        )),
          PopupMenuItem(child: threeDotMenu_Item(theme: theme, label: "About",icon: FontAwesomeIcons.circleInfo,onTap:(){Get.to(() => (AboutScreen()));}        )),

        ];


      },
    );
  }
}
