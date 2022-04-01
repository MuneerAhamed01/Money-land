import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_land/screens/bottom_nav/navbar.dart';
import 'package:money_land/screens/details_screeen/details.dart';
import 'package:money_land/screens/edit_screen/edit_screen.dart';

import 'package:money_land/screens/onboarding_screen/onboarding_one.dart';
import 'package:money_land/screens/onboarding_screen/onboarding_two.dart';
import 'package:money_land/screens/splash_screen/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const Splashscreen());
      case '/onboardingone':
        return MaterialPageRoute(builder: (context) => const OnBoardingOne());
      case '/onboardingtwo':
        return MaterialPageRoute(builder: (context) => const OnboardingTwo());
      case '/home':
        return MaterialPageRoute(builder: (context) => const NavBar());
      case '/details':
        return MaterialPageRoute(builder: (context) => const DetailsPage());
      case '/editscreen':
        return MaterialPageRoute(builder: (context) => const EditScreen());
      default:
        return MaterialPageRoute(builder: (context) => const Splashscreen());
    }
  }
}
