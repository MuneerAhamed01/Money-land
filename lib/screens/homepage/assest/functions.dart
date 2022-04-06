import 'package:flutter/material.dart';
import 'package:money_land/global/styles.dart';
import 'package:money_land/screens/homepage/assest/styles.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';

import '../../statistic_page/assests/widgets.dart';

showDate(BuildContext context, TabController controller) {
  showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          decoration: roundedConrner(lightColor),
          width: double.infinity,
          height: mediaQuery(context, 0.13),
          child: Column(
            children: [
              TabBar(
                controller: controller,
                labelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(color: themeColor),
                tabs: const [
                  Tab(text: 'DAY'),
                  Tab(text: 'MONTHS'),
                  Tab(text: 'YEARS'),
                  Tab(text: 'PERIODS'),
                ],
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx); 
                  },
                  child: const Text(
                    "SAVE",
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
        );
      });
}
