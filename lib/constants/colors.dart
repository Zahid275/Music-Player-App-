import 'package:flutter/material.dart';

class AppColors {
  static Color backgroundColor(bool isLight) =>
      isLight ? Color(0xFFEEF3FB) : Colors.grey.shade900;

  static Color tileColor(bool isLight) =>
      isLight ? Colors.blueGrey.shade100 : Colors.grey.shade600;

  static Color primaryColor(bool isLight) =>
      isLight ? Color(0xFFF8FAFD) : Colors.grey.shade800;

  static Color darkShadow(bool isLight) =>
      isLight ? Color(0xFFD1D9E6) : Colors.grey.shade700;

  static Color lightShadow(bool isLight) =>
      isLight ? Color(0xFFFFFFFF) : Colors.grey.shade200;

  static Color whitte2(bool isLight) =>
      isLight ? Color(0xFFDAD9D9) : Colors.grey;

  static Color btnColor(bool isLight) =>
      isLight ? Colors.grey.shade300 : Colors.grey.shade700;

  static Color btnColor2(bool isLight) =>
      isLight ? Colors.blue.shade300 : Colors.deepOrange;
}
