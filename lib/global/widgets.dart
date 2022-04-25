import 'package:flutter/material.dart';
import 'package:money_land/themes/colors/colors.dart';

class MyTheme {
  static final dark = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(),
  );
  static final light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
  );
}
