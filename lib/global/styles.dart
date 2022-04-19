import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle boldText(double size) {
  return TextStyle(fontSize: size.sp, fontWeight: FontWeight.bold);
}

BottomNavigationBarItem navItem(
  IconData icon,
  String label,
) {
  return BottomNavigationBarItem(
      icon: Icon(
        icon,
      ),
      label: label,
      backgroundColor: lightColor);
}

TextStyle titleText() {
  return TextStyle(
      fontSize: 20.sp, fontWeight: FontWeight.bold, color: realBlack);
}
