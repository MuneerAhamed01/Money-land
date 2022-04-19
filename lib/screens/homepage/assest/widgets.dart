import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_land/screens/homepage/assest/styles.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';
import '../../../themes/colors/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget transactionContainer(
    BuildContext context, String transaction, String amount) {
  return Stack(
    alignment: Alignment.bottomRight,
    children: [
      Container(
        alignment: Alignment.center,
        height: mediaQuery(context, 0.16),
        width: mediaQueryWidth(context, 0.43),
        decoration: roundedConrner(transactionColor),
        child: Text(amount,
            style: TextStyle(
                fontSize: 27.sp,
                fontWeight: FontWeight.bold,
                color: realBlack)),
      ),
      Container(
        alignment: Alignment.center,
        height: mediaQuery(context, 0.03),
        width: mediaQueryWidth(context, 0.29),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              bottomRight: Radius.circular(5.r)),
          color: lightColor,
        ),
        child: Text(
          transaction,
          style: TextStyle(fontSize: 14.sp, color: realBlack),
        ),
      )
    ],
  );
}

Icon iconOf(IconData data) {
  return Icon(
    data,
    size: 18.sp,
    color: realBlack,
  );
}

BoxDecoration roundedConrnerHome(Color color) {
  return BoxDecoration(
    border: Border.all(color: themeColor),
    borderRadius: BorderRadius.circular(5.r),
    color: color,
  );
}

Widget detailsView(double padding, String heading, String listOf) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: padding.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: TextStyle(color: realGrey),
        ),
        Text(listOf)
      ],
    ),
  );
}
