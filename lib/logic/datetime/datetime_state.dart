part of 'datetime_cubit.dart';

class DatetimeState extends Equatable {
  final DateTime? dateTime;
  final String? formatedDate;
  final DateTimeRange? dateTimeRange;
  final String? formatedDateStart;
  final String? formatedDateEnd;

  const DatetimeState(
      {this.dateTime,
      this.formatedDate,
      this.dateTimeRange,
      this.formatedDateEnd,
      this.formatedDateStart});

  @override
  List<Object?> get props => [
        dateTime,
        formatedDate,
        formatedDateEnd,
        formatedDateStart,
        dateTimeRange
      ];
}

class DatetimeInitial extends DatetimeState {
  DatetimeInitial({
    DateTime? dateTime,
    String? formatedDate,
    DateTimeRange? timeRange,
    String? formatedDateStart,
    String? formatedDateEnd,
  }) : super(
            dateTime: dateTime!,
            formatedDate: formatedDate!,
            dateTimeRange: timeRange,
            formatedDateEnd: formatedDateEnd,
            formatedDateStart: formatedDateStart);

  @override
  List<Object?> get props => [
        dateTime,
        formatedDate,
        formatedDateEnd,
        formatedDateStart,
        dateTimeRange
      ];
}
