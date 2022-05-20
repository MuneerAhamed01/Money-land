import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'statistic_change_state.dart';

class StatisticChangeCubit extends Cubit<StatisticChangeState> {
  StatisticChangeCubit() : super(StatisticChangeInitial(value: true));

  onValueChange() {
    emit(StatisticChangeInitial(value: !state.value));
  }
}
