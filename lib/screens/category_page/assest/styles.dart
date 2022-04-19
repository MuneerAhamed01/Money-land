import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/colors/colors.dart';

BoxDecoration roundedConrnerCatgory(Color color) {
  return BoxDecoration(
    borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    color: color,
  );
}

ButtonStyle styleButtonBottom(BuildContext context) => ElevatedButton.styleFrom(
    // maximumSize: Size(10, 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    primary: lightColor,
    shadowColor: Colors.transparent);
