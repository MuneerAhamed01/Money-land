import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_land/themes/colors/colors.dart';

TextStyle boldText(double size) {
  return TextStyle(fontSize: size, fontWeight: FontWeight.bold);
}

BottomNavigationBarItem navItem(
  IconData icon,
  String label,
) {
  return BottomNavigationBarItem(
      icon: Icon(
        icon,
      ),
      label: label,
      backgroundColor: lightColor);
}

TextStyle titleText() {
  return const TextStyle(
      fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black);
}
