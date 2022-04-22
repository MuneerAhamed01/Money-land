import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:money_land/global/styles.dart';
import 'package:money_land/screens/add_page/add_page.dart';
import 'package:money_land/screens/category_page/category.dart';
import 'package:money_land/screens/homepage/home.dart';
import 'package:money_land/screens/settings_page/settings.dart';
import 'package:money_land/themes/colors/colors.dart';

import '../statistic_page/swap_page/swap_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List screens = [
    const HomePage(),
    const SwapInStatics(),
    const AddPage(
      editValues: {},
    ),
    const Category(),
    const Settings()
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: BottomNavigationBar(
          backgroundColor: lightColor,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          selectedItemColor: selectedItem,
          unselectedItemColor: realGrey,
          iconSize: 26.sp,
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
