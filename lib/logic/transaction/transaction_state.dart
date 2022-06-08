part of 'transaction_bloc.dart';

class TransactionState extends Equatable {
  final List<AddTransaction> list;
  final List<AddTransaction> expense;
  final List<AddTransaction> income;
  final double expenseAmount;
  final double incomeAmunt;

  const TransactionState(
      {required this.list,
      required this.expense,
      required this.income,
      required this.expenseAmount,
      required this.incomeAmunt});

  @override
  List<Object?> get props =>
      [list, expense, income, expenseAmount, incomeAmunt];
}

class TransactionInitial extends TransactionState {
  const TransactionInitial(
      {required List<AddTransaction> list,
      required List<AddTransaction> expense,
      required List<AddTransaction> income,
      required double expenseAmount,
      required double incomeAmunt})
      : super(
            list: list,
            expense: expense,
            income: income,
            expenseAmount: expenseAmount,
            incomeAmunt: incomeAmunt);
}
// class TransactionSplit extends TransactionState {
//   final List<AddTransaction> list;
//   TransactionInitial({required this.list});
// }
