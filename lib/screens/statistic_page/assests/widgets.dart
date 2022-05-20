import 'package:flutter/material.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BoxDecoration roundedConrnerStatic(Color color) {
  return BoxDecoration(
    borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
    color: color,
  );
}

BoxDecoration circleDate(Color color) {
  return BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(40.r)),
    color: color,
  );
}

Widget datePickerOf(String type, BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: mediaQuery(context, 0.03),
    width: mediaQueryWidth(context, 0.13),
    decoration: roundedConrnerStaristic(lightColor),
    child: Text(
      type,
      style: TextStyle(
          color: realBlack, fontSize: 10.sp, fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    ),
  );
}

BoxDecoration roundedConrnerStaristic(Color color) {
  return BoxDecoration(
    border: Border.all(color: themeColor),
    borderRadius: BorderRadius.circular(5.r),
    color: color,
  );
}
