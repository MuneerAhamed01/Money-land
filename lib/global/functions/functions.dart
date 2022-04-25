import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

decreseingDate(TabController controller, DateTime dateTime) {
  DateTime? dateIn;
  if (controller.index == 0) {
    dateIn = dateTime.subtract(const Duration(days: 1));
  } else if (controller.index == 1) {
    dateIn = dateTime.subtract(const Duration(days: 31));
  } else {
    dateIn = dateTime.subtract(const Duration(days: 365));
  }

  return dateIn;
}

increasingDate(TabController controller, DateTime dateTime) {
  DateTime? dateIn;
  if (controller.index == 0) {
    dateIn = dateTime.add(const Duration(days: 1));
  } else if (controller.index == 1) {
    dateIn = dateTime.add(const Duration(days: 31));
  } else {
    dateIn = dateTime.add(const Duration(days: 365));
  }
  return dateIn;
}

Future<DateTimeRange> dateRangePicker(
    BuildContext context, DateTimeRange? dateOf) async {
  DateTimeRange? date;

  final initialDate = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(const Duration(days: 3)));

  // ignore: unused_local_variable
  date = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateOf ?? initialDate);

  if (date == null) {
    return initialDate;
  } else {
    return date;
  }
}

String formatPeriodStart(DateTimeRange? dateTimeRange) {
  if (dateTimeRange == null) {
    return 'From';
  } else {
    final formattedOf = DateFormat('dd MM yyyy').format(dateTimeRange.start);
    return formattedOf;
  }
}

String formatPeriodEnd(DateTimeRange? dateTimeRange) {
  if (dateTimeRange == null) {
    return 'To';
  } else {
    final formattedOf = DateFormat('dd MM yyyy').format(dateTimeRange.end);
    return formattedOf;
  }
}
