part of 'tabcontroller_cubit.dart';

abstract class TabcontrollerState extends Equatable {
  const TabcontrollerState();

  
}

class TabcontrollerInitial extends TabcontrollerState {
  final int tablistener;
  const TabcontrollerInitial({required this.tablistener});
@override
  List<Object> get props => [tablistener];

}
