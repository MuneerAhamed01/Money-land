import 'package:flutter/material.dart';
import 'package:money_land/global/styles.dart';
import 'package:money_land/screens/add_page/assest/styles.dart';
import 'package:money_land/screens/add_page/assest/widgets.dart';
import 'package:money_land/screens/category_page/assest/styles.dart';
import 'package:money_land/screens/homepage/assest/styles.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';

Future<void> bottomSheet(BuildContext context, String type) async {
  showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          height: mediaQuery(context, 0.50),
          child: Container(
              decoration: roundedConrnerCatgory(lightColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 60, left: 20, right: 20),
                    child: TextField(
                      decoration: dec(type),
                    ),
                  ),
                  sizedBox(context),
                  ElevatedButton(
                      style: styleButtonBottom(ctx),
                      onPressed: null,
                      child: Text(
                        "Add",
                        style: boldText(15),
                      ))
                ],
              )),
        );
      });
}
