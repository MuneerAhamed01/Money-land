import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mediaQuery(BuildContext context, double heightSize) {
  var height = MediaQuery.of(context).size.height * heightSize.h;
  return height;
}

mediaQueryWidth(BuildContext context, double widthSize) {
  var width = MediaQuery.of(context).size.width * widthSize.w;

  return width;
}
