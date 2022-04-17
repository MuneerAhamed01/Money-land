import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import '../../../database/moneyland_model_class.dart';

DateTime now = DateTime.now();
Future<DateTime> datePicker(
    BuildContext context, String dateof, DateTime? dateTime) async {
  DateTime? date;
  date = await showDatePicker(
      initialDatePickerMode: DatePickerMode.day,
      context: context,
      initialDate: dateTime ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5));
  if (date != null) {
    return date;
  } else {
    return now;
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

Future<DateTime> datePickerNew(
    BuildContext context, TabController controller, DateTime? dateTime) async {
  DateTime? date;

  if (controller.index == 0) {
  } else if (controller.index == 1) {
    date = await showMonthYearPicker(
        initialMonthYearPickerMode: MonthYearPickerMode.month,
        context: context,
        initialDate: dateTime ?? now,
        firstDate: DateTime(now.year - 5),
        lastDate: DateTime(now.year + 5));
  } else {
    date = await showMonthYearPicker(
        initialMonthYearPickerMode: MonthYearPickerMode.year,
        context: context,
        initialDate: now,
        firstDate: DateTime(now.year - 5),
        lastDate: DateTime(now.year + 5));
  }

  if (date != null) {
    return date;
  } else {
    return now;
  }
}

List<Data> chartViewList(List<AddTransaction> list) {
  double amount;
  String? category;
  List visited = [];

  List<Data> seperateCategory = [];
  for (var i = 0; i < list.length; i++) {
    visited.add(0);
  }

  for (var i = 0; i < list.length; i++) {
    amount = list[i].amount!;
    category = list[i].category!.category;

    for (var j = i + 1; j < list.length; j++) {
      if (list[i].category!.category == list[j].category!.category) {
        amount += list[j].amount!;
        visited[j] = -1;
      }
    }
    if (visited[i] != -1) {
      seperateCategory.add(Data(categories: category, amount: amount));
    }
  }
  return seperateCategory;
}

class Data {
  String? categories;
  double? amount;
  Data({required this.categories, required this.amount});
}
