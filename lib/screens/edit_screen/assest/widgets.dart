import 'package:flutter/material.dart';

import '../../add_page/assest/styles.dart';

Widget textFieldsEdit(String label, int line, String value) {
  return TextFormField(
    initialValue: value,
    maxLines: line,
    decoration: dec(label),
  );
}
