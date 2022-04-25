import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_land/screens/homepage/assest/styles.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';

import '../../../database/moneyland_model_class.dart';

showDate(BuildContext context, TabController controller) {
  showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          decoration: roundedConrner(lightColor),
          width: double.infinity,
          height: 100.h,
          child: Column(
            children: [
              TabBar(
                controller: controller,
                labelColor: realBlack,
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
                  child: Text(
                    "SAVE",
                    style: TextStyle(color: realBlack),
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

int? getKey(List<AddTransaction> getKey, int key) {
  int? accessKey;

  for (var i = 0; i < getKey.length; i++) {
    if (getKey[i].key == key) {
      accessKey = getKey[i].key;
      break;
    }
  }
  return accessKey;
}

int? getKeyCategory(List<Categories> getKey, String key) {
  int? accessKey;

  for (var i = 0; i < getKey.length; i++) {
    if (getKey[i].category == key) {
      accessKey = getKey[i].key;
      break;
    }
  }
  return accessKey;
}

List<AddTransaction> gotoFilter(
    {required DateTime range,
    required TabController controller,
    required List<AddTransaction> list,
    required DateTimeRange dateTimeRange}) {
  List<AddTransaction> filteredList = [];

  if (controller.index <= 2) {
    print("income ${list}");
    for (var i = 0; i < list.length; i++) {
      if (list[i].visible == false) {
        if (controller.index == 0) {
          if (list[i].date!.day == range.day &&
              list[i].date!.month == range.month &&
              list[i].date!.year == range.year) {
            filteredList.add(list[i]);
          }
        } else if (controller.index == 1) {
          if (list[i].date!.month == range.month &&
              list[i].date!.year == range.year) {
            filteredList.add(list[i]);
          }
        } else {
          if (list[i].date!.year == range.year) {
            filteredList.add(list[i]);
          }
        }
      }
    }
  } else {
    for (var i = 0; i < list.length; i++) {
      if (list[i].visible == false) {
        final dateAfter = dateTimeRange.start.subtract(const Duration(days: 1));
        final dateBefore = dateTimeRange.end.add(const Duration(days: 1));

        if (list[i].date!.isAfter(dateAfter) &&
            list[i].date!.isBefore(dateBefore)) {
          filteredList.add(list[i]);
        }
      }
    }
  }

  return filteredList;
}
