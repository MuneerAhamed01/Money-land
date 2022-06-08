import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_land/database/moneyland_model_class.dart';
import 'package:money_land/main.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  static final box = Hive.box<AddTransaction>(db_transaction);

  TransactionBloc()
      : super(TransactionInitial(
            list: box.values.toList(),
            expense: const [],
            income: const [],
            expenseAmount: 0,
            incomeAmunt: 0)) {
    on<AddTrans>((event, emit) async {
      await box.add(event.transaction);
      emit(TransactionInitial(
          list: box.values.toList(),
          expense: state.expense,
          income: state.income,
          incomeAmunt: state.incomeAmunt,
          expenseAmount: state.expenseAmount));
    });
    on<DeleteTransaction>((event, emit) async {
      await box.delete(event.key);
      emit(TransactionInitial(
          list: box.values.toList(),
          expense: state.expense,
          income: state.income,
          incomeAmunt: state.incomeAmunt,
          expenseAmount: state.expenseAmount));
    });
    on<EditEvent>((event, emit) async {
      await box.put(event.key, event.transaction);
      emit(TransactionInitial(
          list: box.values.toList(),
          expense: state.expense,
          income: state.income,
          incomeAmunt: state.incomeAmunt,
          expenseAmount: state.expenseAmount));
    });

    on<GetFilteredList>((event, emit) {
      final list = box.values.toList();
      List<AddTransaction> filteredList = [];
      List<AddTransaction> income = [];
      List<AddTransaction> expense = [];
      double expenseAmount = 0;
      double incomeAmount = 0;

      if (event.tabIndex <= 2) {
        for (var i = 0; i < list.length; i++) {
          if (list[i].visible == false) {
            if (event.tabIndex == 0) {
              if (list[i].date!.day == event.dateTime.day &&
                  list[i].date!.month == event.dateTime.month &&
                  list[i].date!.year == event.dateTime.year) {
                filteredList.add(list[i]);
              }
            } else if (event.tabIndex == 1) {
              if (list[i].date!.month == event.dateTime.month &&
                  list[i].date!.year == event.dateTime.year) {
                filteredList.add(list[i]);
              }
            } else {
              if (list[i].date!.year == event.dateTime.year) {
                filteredList.add(list[i]);
              }
            }
          }
        }
      } else {
        for (var i = 0; i < list.length; i++) {
          if (list[i].visible == false) {
            final dateAfter =
                event.dateTimeRange.start.subtract(const Duration(days: 1));
            final dateBefore =
                event.dateTimeRange.end.add(const Duration(days: 1));

            if (list[i].date!.isAfter(dateAfter) &&
                list[i].date!.isBefore(dateBefore)) {
              filteredList.add(list[i]);
            }
          }
        }
      }

      for (var i = 0; i < filteredList.length; i++) {
        if (filteredList[i].type == CategoryType.expense) {
          expense.add(filteredList[i]);
        } else {
          income.add(filteredList[i]);
        }
      }
      for (var element in expense) {
        expenseAmount = expenseAmount + element.amount!;
      }
      for (var element in income) {
        incomeAmount = incomeAmount + element.amount!;
      }

      emit(TransactionInitial(
          list: filteredList,
          expense: expense,
          income: income,
          incomeAmunt: incomeAmount,
          expenseAmount: expenseAmount));
    });
  }
}

