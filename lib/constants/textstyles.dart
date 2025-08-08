import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/constants/colors.dart';

TextStyle primaryTextStyle({
  double size = 18.0,
  FontWeight fontweight = FontWeight.w400,
   color,
}) {
  return GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: color,
  );
}

appBarTextStyle(isLight){
  return TextStyle(
    color: AppColors.tabIconColor(isLight),
    fontSize: 28,
    fontWeight: FontWeight.w500,

  );
}
tileTextStyle(){
  return GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w400);
}


