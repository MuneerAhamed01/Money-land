import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InputDecoration dec(String label) {
  return InputDecoration(
      errorStyle: TextStyle(height: 0.h),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      floatingLabelStyle: const TextStyle(color: Colors.black),
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0.r),
      ));
}

TextStyle styleText = TextStyle(color: Colors.black, fontSize: 17.sp);
