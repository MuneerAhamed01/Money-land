part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent {}

class AddTrans extends TransactionEvent {
  final AddTransaction transaction;
  AddTrans({required this.transaction});
}

class DeleteTransaction extends TransactionEvent {
  
  final int key;
  DeleteTransaction({required this.key});
}

class EditEvent extends TransactionEvent {
  final int key;
  final AddTransaction transaction;
  EditEvent({required this.key, required this.transaction});
}

class GetFilteredList extends TransactionEvent {
  final int tabIndex;
  final DateTime dateTime;
  final DateTimeRange dateTimeRange;

  GetFilteredList(
      {required this.tabIndex,
      required this.dateTime,
      required this.dateTimeRange});
}
