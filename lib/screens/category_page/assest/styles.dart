import 'package:flutter/material.dart';

import '../../../themes/colors/colors.dart';

BoxDecoration roundedConrnerCatgory(Color color) {
  return BoxDecoration(
    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    color: color,
  );
}

ButtonStyle styleButtonBottom(BuildContext context) => ElevatedButton.styleFrom(
    // maximumSize: Size(10, 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    primary: lightColor,
    shadowColor: Colors.transparent);
