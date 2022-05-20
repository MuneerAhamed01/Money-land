import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tabcontroller_state.dart';

class TabcontrollerCubit extends Cubit<TabcontrollerState> {
  TabcontrollerCubit() : super(const TabcontrollerInitial(tablistener: 0));

  changeIndex(int value) {
    emit(TabcontrollerInitial(tablistener: value));
  }
}
