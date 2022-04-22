import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:money_land/global/styles.dart';
import 'package:money_land/screens/bottom_nav/navbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with TickerProviderStateMixin {
  AnimationController? scaleController;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController!);
    super.initState();
    gotoPermission();
    moveSplash(context);
  }

  getSwitchValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSwitchedFT = prefs.getBool("switchState")!;
    if (isSwitchedFT == true) {}
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scaleController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.12),
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText("Money Land",
                        textStyle: boldText(20),
                        speed: const Duration(milliseconds: 150)),
                  ],
                  isRepeatingAnimation: false,
                  repeatForever: false,
                  displayFullTextOnTap: false,
                ),
                SizedBox(height: height * 0.15),
                Image.asset(
                    "lib/screens/splash_screen/assest/images/undraw_financial_data_es63.png")
              ],
            ),
          ),
        ));
  }

  moveSplash(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    sharedPreferences = await SharedPreferences.getInstance();

    final value = sharedPreferences.getBool("move");
    if (value == true) {
      Navigator.of(context).pushReplacement(
        PageTransition(
            opaque: true,
            duration: const Duration(milliseconds: 1200),
            type: PageTransitionType.rightToLeftWithFade,
            child: const NavBar()),
      );
    } else {
      Navigator.pushReplacementNamed(context, '/onboardingone');
    }
  }

  gotoPermission() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }
}
