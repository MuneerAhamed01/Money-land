import 'dart:math';

import 'package:flutter/material.dart';
import 'package:money_land/global/styles.dart';
import 'package:money_land/screens/homepage/assest/styles.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';

import '../../../database/moneyland_model_class.dart';
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

double totalTransaction(List<AddTransaction> exp, CategoryType type) {
  double totaltransactionOf = 0;

  for (var i = 0; i < exp.length; i++) {
    if (exp[i].type == type) {
      totaltransactionOf = exp[i].amount! + totaltransactionOf;
    }
  }
  return totaltransactionOf;
}

int? getKey(List<AddTransaction> getKey, String name) {
  int? accessKey;

  for (var i = 0; i < getKey.length; i++) {
    if (getKey[i].name == name) {
      accessKey = getKey[i].key;
      break;
    }
  }
  return accessKey;
}
