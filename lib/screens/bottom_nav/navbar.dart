import 'package:flutter/material.dart';
import 'package:money_land/global/styles.dart';
import 'package:money_land/screens/add_page/add_page.dart';
import 'package:money_land/screens/bottom_nav/assest/widget.dart';
import 'package:money_land/screens/category_page/category.dart';
import 'package:money_land/screens/homepage/home.dart';
import 'package:money_land/screens/settings_page/settings.dart';
import 'package:money_land/screens/statistic_page/statistic.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';

import '../statistic_page/swap_page/swap_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List screens = [
    const HomePage(),
    const SwapInStatics(),
    const AddPage(),
    const Category(),
    const Settings()
  ];
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        // height: mediaQuery(context, 0.08),
        // decoration: roundedConrnerNav(),
        child: BottomNavigationBar(
          backgroundColor: lightColor,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          selectedItemColor: const Color.fromRGBO(255, 103, 103, 100),
          unselectedItemColor: Colors.grey,
          iconSize: 26,
          items: [
            navItem(Icons.home_sharp, "Home"),
            navItem(Icons.pie_chart, "Statistic"),
            navItem(Icons.add_box_rounded, "Add"),
            navItem(Icons.category, "Category"),
            navItem(Icons.settings, "Settings")
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          currentIndex: currentIndex,
        ),
      ),
    );
  }
}
