import 'package:flutter/cupertino.dart';
import 'package:money_land/themes/colors/colors.dart';

BoxDecoration roundedConrner(Color color) {
  return BoxDecoration(
    // border: Border.all(color: themeColor),
    borderRadius: BorderRadius.circular(5),
    color: color,
  );
}

BoxDecoration roundedConrnerTwo(Color color) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    color: color,
  );
}
