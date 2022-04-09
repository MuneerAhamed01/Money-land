import 'package:flutter/material.dart';

InputDecoration dec(String label) {
  return InputDecoration(
      errorStyle: const TextStyle(height: 0),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      floatingLabelStyle: const TextStyle(color: Colors.black),
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ));
}

TextStyle styleText = const TextStyle(color: Colors.black, fontSize: 17);
