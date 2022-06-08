import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:money_land/database/database_crud/db_crud_categories.dart';
import 'package:money_land/database/moneyland_model_class.dart';
import 'package:money_land/main.dart';

import '../../screens/category_page/assest/functions.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  static final box = Hive.box<Categories>(db_Name);
  static final expenseList =
      seperateCategory(CategoryType.expense, box.values.toList());
  static final incomeList =
      seperateCategory(CategoryType.income, box.values.toList());
  CategoryBloc()
      : super(CategoryInitial(
            categoriesList: Hive.box<Categories>(db_Name).values.toList(),
            expense: expenseList,
            income: incomeList)) {
    on<AddCategory>((event, emit) async {
      final transactionBox = Hive.box<AddTransaction>(db_transaction);

      for (var element in transactionBox.values.toList()) {
        if (event.list.category!.toLowerCase().trim() ==
            element.category!.category!.toLowerCase().trim()) {
          await transactionBox.put(
              element.key,
              AddTransaction(
                  amount: element.amount,
                  category: event.list,
                  date: element.date,
                  notes: element.notes,
                  type: element.type,
                  visible: false));
          element.category!.category = event.list.category;
        }
      }
      await box.add(event.list);
      final expenseList =
          seperateCategory(CategoryType.expense, box.values.toList());
      final incomeList =
          seperateCategory(CategoryType.income, box.values.toList());
      emit(CategoryInitial(
          categoriesList: box.values.toList(),
          expense: expenseList,
          income: incomeList));
    });
    on<DeleteCategory>((event, emit) async {
      final listVisible =
          Hive.box<AddTransaction>(db_transaction).values.toList();

      for (var element in listVisible) {
        final transactionBox = Hive.box<AddTransaction>(db_transaction);
        if (element.category!.category!.toLowerCase().trim() ==
            event.name.toLowerCase().trim()) {
          await transactionBox.put(
              element.key,
              AddTransaction(
                  amount: element.amount,
                  category: element.category,
                  date: element.date,
                  notes: element.notes,
                  type: element.type,
                  visible: true));
        }
      }

      await box.delete(event.key);
      final expenseList =
          seperateCategory(CategoryType.expense, box.values.toList());
      final incomeList =
          seperateCategory(CategoryType.income, box.values.toList());
      emit(CategoryInitial(
          categoriesList: box.values.toList(),
          expense: expenseList,
          income: incomeList));
    });
    on<EditCategory>((event, emit) async {
      await box.put(event.key, event.list);
      final expenseList =
          seperateCategory(CategoryType.expense, box.values.toList());
      final incomeList =
          seperateCategory(CategoryType.income, box.values.toList());
      emit(CategoryInitial(
          categoriesList: box.values.toList(),
          expense: expenseList,
          income: incomeList));
    });
  }
}
