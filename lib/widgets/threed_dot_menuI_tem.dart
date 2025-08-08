import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../Views/home_screen.dart';
import '../constants/textstyles.dart';

Widget threeDotMenu_Item({required void Function()? onTap,required bool theme,required label,IconData? icon,required}) {
  return TextButton(
    onPressed: onTap,
    child: Row(
      children: [
      icon !=null ?  Icon(
          icon,
          color: theme ? Colors.grey.shade500 : Colors.grey.shade300,
          size: 20,
        ):SizedBox(),
        SizedBox(width: 20.sp),
        Text(
          "$label",
          style: primaryTextStyle(
            size: 18,
            color: theme ? Colors.black : Colors.white,
          ),
        ),
        SizedBox(height: 20.sp),

      ],
    ),
  );
}
