import 'package:flutter/material.dart';
import 'package:money_land/screens/splash_screen/splash_screen.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      // home: const Splashscreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
