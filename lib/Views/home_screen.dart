import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:music_player/Views/tabs.dart';
import 'package:music_player/constants/colors.dart';
import 'package:music_player/constants/textstyles.dart';
import 'package:music_player/controllers/home_controller.dart';
import 'package:music_player/controllers/play_screen_controller.dart';
import 'package:music_player/widgets/my_drawer.dart';


import '../controllers/themeController.dart';
import '../services/db_services.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  final playController = Get.find<PlayScreenController>();
  final themeController = Get.find<ThemeController>();

   HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DB_Services.deleteAll();
    return Obx(() {
      bool isLight = themeController.isLight.value;

      return DefaultTabController(

        initialIndex: 0,
        length: 2,
        child: Scaffold(
          drawer: MyDrawer(
            isLight: isLight,
            drawerColor: AppColors.primaryColor(isLight),
          ),
          backgroundColor: AppColors.backgroundColor(isLight),
          appBar: AppBar(
            title: Text("Melodia",style: primaryTextStyle(size: 23),),
            bottom: TabBar(
              indicatorColor: AppColors.btnColor(isLight),
              labelColor: AppColors.btnColor2(isLight),
              unselectedLabelColor: AppColors.darkShadow(!isLight),
              tabs: [
                Tab(icon: Icon(FontAwesomeIcons.house), text: "Home"),
                Tab(
                  icon: Icon(FontAwesomeIcons.solidHeart),
                  text: "Favourites",
                ),
              ],
            ),
            backgroundColor: AppColors.backgroundColor(isLight),
          ),

          body: TabBarView(
            children: [
              homeTab(controller, isLight),
              favTab(playController.favSongs,isLight),
            ],
          ),
        ),
      );
    });
  }
}
