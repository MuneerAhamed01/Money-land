import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:money_land/global/styles.dart';
import 'package:money_land/logic/bottomnav/bottomnavigation_cubit.dart';
import 'package:money_land/screens/add_page/add_page.dart';
import 'package:money_land/screens/category_page/category.dart';
import 'package:money_land/screens/homepage/home.dart';
import 'package:money_land/screens/settings_page/settings.dart';
import 'package:money_land/themes/colors/colors.dart';

import '../statistic_page/swap_page/swap_page.dart';

class NavBar extends StatelessWidget {
  NavBar({Key? key}) : super(key: key);

 static  int? state = 1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomnavigationCubit, BottomnavigationState>(
      builder: (context, state) {
        state as BottomnavigationInitial;
        return Scaffold(
          backgroundColor: state.index < 2 ? homeScaffoldBackground : realWhite,
          body: screens[state.index],
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(14.r)),
            child: BottomNavigationBar(
              backgroundColor: lightColor,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              selectedItemColor: selectedItem,
              unselectedItemColor: realGrey,
              iconSize: 25.sp,
              items: [
                navItem(Icons.home_sharp, "Home"),
                navItem(Icons.pie_chart, "Statistic"),
                navItem(Icons.add_box_rounded, "Add"),
                navItem(Icons.category, "Category"),
                navItem(Icons.settings, "Settings")
              ],
              onTap: (index) {
                context.read<BottomnavigationCubit>().onIndexChanging(index);
              },
              currentIndex: state.index,
            ),
          ),
        );
      },
    );
  }

  final List screens = [
     HomePage(state: state!,),
    const SwapInStatics(),
    const AddPage(
      editValues: {},
    ),
    const Category(),
    const Settings()
  ];
}
