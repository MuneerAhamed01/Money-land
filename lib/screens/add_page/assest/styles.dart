import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

InputDecoration dec(String label) {
  return InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      floatingLabelStyle: TextStyle(color: Colors.black),
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ));
}

TextStyle styleText = TextStyle(color: Colors.black, fontSize: 17);
