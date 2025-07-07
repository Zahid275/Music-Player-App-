import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle primaryTextStyle({
  double size = 18.0,
  FontWeight fontweight = FontWeight.w400,
   color,
}) {
  return GoogleFonts.poppins(
    fontSize: size,
    fontWeight: fontweight,
    color: color,
  );
}
