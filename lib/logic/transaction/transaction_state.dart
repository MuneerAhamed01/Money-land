part of 'transaction_bloc.dart';

@immutable
abstract class TransactionState {}

class TransactionInitial extends TransactionState {
  final List<AddTransaction> list;
  TransactionInitial({required this.list});
}
