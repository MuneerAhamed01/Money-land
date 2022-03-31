import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'styles.dart';

DateTime now = DateTime.now();

DateTime? date;

//Date choosing start

Future<String> datePicker(BuildContext context) async {
  date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030));
  if (date != null) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(date!);

    return formattedDate;
  } else {
    return 'Not Selected';
  }
}

//Date choosing end

//for hide keyboard

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

List<DropdownMenuItem<String>>? category(String? selected, List<String> items) {
  return items
      .map((String item) => DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          ))
      .toList();
}
