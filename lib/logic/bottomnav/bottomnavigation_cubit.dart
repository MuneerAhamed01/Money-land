import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottomnavigation_state.dart';

class BottomnavigationCubit extends Cubit<BottomnavigationState> {
  BottomnavigationCubit() : super(const BottomnavigationInitial(index: 0));

  onIndexChanging(int index) {
    emit(BottomnavigationInitial(index: index));
  }
}
