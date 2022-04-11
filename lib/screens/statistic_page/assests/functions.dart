import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../database/moneyland_model_class.dart';
import '../../../main.dart';

DateTime now = DateTime.now();
Future<String> datePicker(BuildContext context, String dateof) async {
  DateTime? date;
  date = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.year,
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5));
  if (date != null) {
    String formattedDate = DateFormat(dateof).format(date);

    return formattedDate;
  } else {
    return 'Not Selected';
  }
}

List<AddTransaction> splitTransaction(
    List<AddTransaction> transaction, CategoryType type) {
  List<AddTransaction> split = [];

  for (var i = 0; i < transaction.length; i++) {
    if (transaction[i].type == type) {
      split.add(transaction[i]);
    }
  }

  return split;
}
