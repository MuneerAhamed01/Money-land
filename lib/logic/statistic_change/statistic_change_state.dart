part of 'statistic_change_cubit.dart';

class StatisticChangeState extends Equatable {
  bool value;
  @override
  StatisticChangeState({required this.value});
  List<Object> get props => [value];
}

class StatisticChangeInitial extends StatisticChangeState {
  StatisticChangeInitial({required bool value}) : super(value: value);

  @override
  List<Object> get props => [value];
}
