part of 'notificaton_cubit.dart';

class NotificatonState extends Equatable {
   final List<AddTransaction> transactionList;
  final double totalExp;
  final double totalInc;
  final bool value;

  const NotificatonState(
      {required this.totalExp,
      required this.totalInc,
      required this.transactionList,required this.value});
  @override
  List<Object> get props => [transactionList, totalExp, totalInc,value];
}

class NotificationInitial extends NotificatonState {
  const NotificationInitial({required double totalExp, required double totalInc, required List<AddTransaction> transactionList, required bool value}) : super(totalExp: totalExp, totalInc: totalInc, transactionList: transactionList, value: value);
 
}

// class ChangeListTail extends NotificatonState {
  
//   const ChangeListTail({required this.value});
//   @override
//   List<Object> get props => [value];
// }
