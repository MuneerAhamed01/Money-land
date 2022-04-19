import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_land/global/styles.dart';

import 'package:money_land/themes/colors/colors.dart';

import '../../themes/mediaquery/mediaquery.dart';

class OnBoardingOne extends StatelessWidget {
  const OnBoardingOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 76.h,
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.w, bottom: 20.h),
              child: Text(
                "Make your finance\nBetter with us",
                style: boldText(40.sp),
              ),
            ),
            SizedBox(height: mediaQuery(context, 0.2)),
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(
                    "lib/screens/onboarding_screen/assest/images/imageofboard.svg"),
                Positioned(
                  right: -45.w,
                  child: SizedBox(
                    height: mediaQuery(context, 0.08),
                    width: mediaQueryWidth(context, 0.20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: themeColor),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/onboardingtwo');
                        },
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: realBlack,
                          size: 25.sp,
                        )),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
