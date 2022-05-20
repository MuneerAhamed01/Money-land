part of 'notificaton_cubit.dart';

class NotificatonState extends Equatable {
  const NotificatonState();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class NotificationInitial extends NotificatonState {
  final List<AddTransaction> transactionList;
  final double totalExp;
  final double totalInc;

  const NotificationInitial(
      {required this.totalExp,
      required this.totalInc,
      required this.transactionList});
  @override
  List<Object> get props => [transactionList, totalExp, totalInc];
}

class ChangeListTail extends NotificatonState {
  final bool value;
  const ChangeListTail({required this.value});
  @override
  List<Object> get props => [value];
}
