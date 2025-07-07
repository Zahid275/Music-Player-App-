import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Actionbtn extends StatelessWidget {
  final Icon icon;
  void Function()? onTap;
  Color btnColor;
  Actionbtn({super.key, required this.icon,required this.onTap,required this.btnColor});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.sp,
      width: 60.sp,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(blurRadius: 5, spreadRadius: 1, offset: Offset(1, 1)),
        ],
        color: btnColor,
        borderRadius: BorderRadius.circular(60.sp),
      ),
      child: IconButton(
        onPressed: onTap,
        icon:  icon,),
    );
  }
}
