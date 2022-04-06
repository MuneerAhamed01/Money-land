import 'package:flutter/material.dart';
import 'package:money_land/global/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    moveSplash(context);
    // TODO: implement initState
    super.initState();
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
                Text(
                  "Money Land",
                  style: boldText(50),
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
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      Navigator.pushReplacementNamed(context, '/onboardingone');
    }
  }
}
