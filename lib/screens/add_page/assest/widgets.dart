import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/colors/colors.dart';
import '../../../themes/mediaquery/mediaquery.dart';
import 'styles.dart';

Widget sizedBox(BuildContext context) {
  return SizedBox(
    height: mediaQuery(context, 0.03),
  );
}

Widget textFields(TextEditingController controller, String label, int line) {
  return TextFormField(
    maxLines: line,
    decoration: dec(label),
  );
}

ButtonStyle styleButton(BuildContext context) => ElevatedButton.styleFrom(
    // maximumSize: Size(10, 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    primary: lightColor,
    shadowColor: Colors.transparent);
