import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

part 'datetime_state.dart';

class DatetimeCubit extends Cubit<DatetimeState> {
  static String formatedStart = DateFormat('dd-MM-yyyy').format(DateTime.now());
  DatetimeCubit()
      : super(DatetimeInitial(
            dateTime: DateTime.now(),
            formatedDate: DateFormat('MMM yyyy').format(DateTime.now()),
            timeRange: DateTimeRange(
                start: DateTime.now(),
                end: DateTime.now().add(const Duration(days: 3))),
            formatedDateStart: formatedStart,
            formatedDateEnd: formatedStart));

  void decreasingDate(TabController controller) {
    DateTime dateTime;
    String formated;
    if (controller.index == 0) {
      dateTime = state.dateTime!.subtract(const Duration(days: 1));
      formated = DateFormat('dd MMM yy').format(dateTime);
    } else if (controller.index == 1) {
      dateTime = state.dateTime!.subtract(const Duration(days: 31));
      formated = DateFormat('MMMM yyyy').format(dateTime);
    } else {
      dateTime = state.dateTime!.subtract(const Duration(days: 365));
      formated = DateFormat('yyyy').format(dateTime);
    }

    emit(DatetimeInitial(
        dateTime: dateTime,
        formatedDate: formated,
        timeRange: state.dateTimeRange,
        formatedDateEnd: state.formatedDateEnd,
        formatedDateStart: state.formatedDateStart));
  }

  void increasingDate(TabController controller) {
    DateTime dateTime;
    String formated;
    if (controller.index == 0) {
      dateTime = state.dateTime!.add(const Duration(days: 1));
      formated = DateFormat('dd MMM yy').format(dateTime);
    } else if (controller.index == 1) {
      dateTime = state.dateTime!.add(const Duration(days: 31));
      formated = DateFormat('MMMM yyyy').format(dateTime);
    } else {
      dateTime = state.dateTime!.add(const Duration(days: 365));
      formated = DateFormat('yyyy').format(dateTime);
    }

    emit(DatetimeInitial(
        dateTime: dateTime,
        formatedDate: formated,
        formatedDateEnd: state.formatedDateEnd,
        formatedDateStart: state.formatedDateStart,
        timeRange: state.dateTimeRange));
  }

  onDate(TabController controller) {
    String formated = state.formatedDate!;
    if (controller.index == 0) {
      // dateTime = state.dateTime!!.subtract(const Duration(days: 1));
      formated = DateFormat('dd MMM yy').format(state.dateTime!);
    } else if (controller.index == 1) {
      // dateTime = state.dateTime!!.subtract(const Duration(days: 31));
      formated = DateFormat('MMMM yyyy').format(state.dateTime!);
    } else {
      // dateTime = state.dateTime!!.subtract(const Duration(days: 365));
      formated = DateFormat('yyyy').format(state.dateTime!);
    }

    emit(DatetimeInitial(
        dateTime: state.dateTime,
        formatedDate: formated,
        formatedDateEnd: state.formatedDateEnd,
        formatedDateStart: state.formatedDateStart,
        timeRange: state.dateTimeRange));
  }

  datePickerOn(BuildContext context, TabController controller) async {
    final now = DateTime.now();
    String formated = state.formatedDate!;
    DateTime? date;

    if (controller.index == 0) {
      date = await showDatePicker(
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDatePickerMode: DatePickerMode.day,
          context: context,
          initialDate: state.dateTime!,
          firstDate: DateTime(now.year - 5),
          lastDate: DateTime(now.year + 5));
      // dateTime = state.dateTime!!.subtract(const Duration(days: 1));
      formated = DateFormat('dd MMM yy').format(date!);
    } else if (controller.index == 1) {
      date = await showMonthYearPicker(
          initialMonthYearPickerMode: MonthYearPickerMode.month,
          context: context,
          initialDate: state.dateTime!,
          firstDate: DateTime(now.year - 5),
          lastDate: DateTime(now.year + 5));
      // dateTime = state.dateTime!!.subtract(const Duration(days: 31));
      formated = DateFormat('MMMM yyyy').format(date!);
    } else if (controller.index == 2) {
      date = await showMonthYearPicker(
          initialMonthYearPickerMode: MonthYearPickerMode.year,
          context: context,
          initialDate: now,
          firstDate: DateTime(now.year - 5),
          lastDate: DateTime(now.year + 5));
      // dateTime = state.dateTime!!.subtract(const Duration(days: 365));
      formated = DateFormat('yyyy').format(date!);
    }

    emit(DatetimeInitial(
        dateTime: date,
        formatedDate: formated,
        formatedDateEnd: state.formatedDateEnd,
        formatedDateStart: state.formatedDateStart,
        timeRange: state.dateTimeRange));
  }

  dateRangPicker(BuildContext context) async {
    DateTimeRange? date = state.dateTimeRange;

    date = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: date);
    final formattedStart = DateFormat('dd-MM-yyyy').format(date!.start);
    final formattedEnd = DateFormat('dd-MM-yyyy').format(date.end);

    emit(DatetimeInitial(
        formatedDateStart: formattedStart,
        formatedDateEnd: formattedEnd,
        timeRange: date,
        formatedDate: state.formatedDate,
        dateTime: state.dateTime));
  }
}
