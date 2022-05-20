part of 'bottomnavigation_cubit.dart';

abstract class BottomnavigationState extends Equatable {
  const BottomnavigationState();

 
}

class BottomnavigationInitial extends BottomnavigationState {
  final int index;

  const BottomnavigationInitial({required this.index});

  @override
  List<Object> get props => [index];

}
