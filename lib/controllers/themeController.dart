import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isLight = true.obs;

  //if isLight is true then theme would be light otherwise dark theme
  ThemeMode get theme => isLight.value ? ThemeMode.light : ThemeMode.dark;

  //function to change the theme,called when switch is pressed in settings screen
  void toggleTheme() {
    isLight.value = !isLight.value;
    Get.changeThemeMode(theme);
  }
}