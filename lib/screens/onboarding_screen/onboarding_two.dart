import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_land/screens/splash_screen/splash_screen.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';

import '../../global/styles.dart';
import '../../themes/colors/colors.dart';

class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SvgPicture.asset(
                "lib/screens/onboarding_screen/assest/images/undraw_personal_goals_re_iow7 1.svg",
                width: mediaQueryWidth(context, 0.99),
              ),
              Text(
                "Track your income\nand expense.",
                style: boldText(40),
                textAlign: TextAlign.center,
              ),
            ],
          ),

          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: ElevatedButton(
              onPressed: () {
                sharedPreferences.setBool("move", true);
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text(
                "   Next   ",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: lightColor,
                  shadowColor: Colors.transparent),
            ),
          )
        ],
      ),
    ));
  }
}
