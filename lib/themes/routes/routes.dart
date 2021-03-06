import 'package:flutter/material.dart';
import 'package:money_land/screens/add_page/add_page.dart';
import 'package:money_land/screens/bottom_nav/navbar.dart';
import 'package:money_land/screens/onboarding_screen/onboarding_one.dart';

import 'package:money_land/screens/splash_screen/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => const MyCustomSplashScreen());
      case '/onboardingone':
        return MaterialPageRoute(builder: (context) => const OnBoardingOne());

      case '/home':
        return MaterialPageRoute(builder: (context) =>  NavBar());
      case '/editscreen':
        final args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => AddPage(
                  editValues: args,
                ));
      default:
        return MaterialPageRoute(builder: (context) =>  NavBar());
    }
  }
}
