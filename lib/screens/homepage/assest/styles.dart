import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BoxDecoration roundedConrner(Color color) {
  return BoxDecoration(
    // border: Border.all(color: themeColor),
    borderRadius: BorderRadius.circular(5.r),
    color: color,
  );
}

BoxDecoration roundedConrnerTwo(Color color) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(5.r),
    color: color,
  );
}
