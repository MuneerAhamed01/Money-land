import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_land/screens/homepage/assest/styles.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';

import '../../../themes/colors/colors.dart';

Widget transactionContainer(
    BuildContext context, String transaction, String amount) {
  return Stack(
    alignment: Alignment.bottomRight,
    children: [
      Container(
        alignment: Alignment.center,
        height: mediaQuery(context, 0.16),
        width: mediaQueryWidth(context, 0.45),
        decoration: roundedConrner(const Color.fromARGB(255, 233, 121, 121)),
        child: Text(amount,
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
      Container(
        alignment: Alignment.center,
        height: mediaQuery(context, 0.03),
        width: mediaQueryWidth(context, 0.29),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), bottomRight: Radius.circular(5)),
          color: lightColor,
        ),
        child: Text(
          transaction,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      )
    ],
  );
}

Icon iconOf(IconData data) {
  return Icon(
    data,
    size: 18,
    color: Colors.black,
  );
}

Widget datePickerOfHome(String type, BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: mediaQuery(context, 0.03),
    width: mediaQueryWidth(context, 0.20),
    decoration: roundedConrnerHome(lightColor),
    child: Text(
      type,
      style: const TextStyle(
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

BoxDecoration roundedConrnerHome(Color color) {
  return BoxDecoration(
    border: Border.all(color: themeColor),
    borderRadius: BorderRadius.circular(5),
    color: color,
  );
}
