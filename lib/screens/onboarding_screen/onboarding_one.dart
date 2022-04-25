import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:money_land/themes/colors/colors.dart';
import '../splash_screen/splash_screen.dart';

class OnBoardingOne extends StatelessWidget {
  const OnBoardingOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: IntroductionScreen(
      globalBackgroundColor: realWhite,
      pages: [
        PageViewModel(
            titleWidget: Text(
              "Make your Finance \n Better",
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            body: "Store the information of each transaction",
            image: SvgPicture.asset(
              "lib/screens/onboarding_screen/assest/images/005.svg",
              width: 250.w,
            )),
        PageViewModel(
            titleWidget: Text(
              "Track your income\nand expense.",
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            body: "See your transactions in high details",
            image: SvgPicture.asset(
              "lib/screens/onboarding_screen/assest/images/undraw_stock_prices_re_js33.svg",
              width: 250.w,
            ))
      ],
      done: Padding(
        padding: EdgeInsets.only(left: 25.w),
        child: Text(
          "Start",
          style: TextStyle(color: realBlack, fontSize: 16.sp),
        ),
      ),
      onDone: () {
        sharedPreferences!.setBool("key", true);
        Navigator.pushReplacementNamed(context, '/home');
      },
      showNextButton: false,
    ));
  }
}
