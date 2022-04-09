import 'package:hive_flutter/adapters.dart';

import '../../main.dart';
import '../moneyland_model_class.dart';

class TransactionDB {
  Future<void> addTransactions(AddTransaction value) async {
    final dbOpen = Hive.box<AddTransaction>(db_transaction);

    await dbOpen.add(value);
    refreshUI();
  }

  Future<List<AddTransaction>> getTrasaction() async {
    final dbOpen = Hive.box<AddTransaction>(db_transaction);
    return dbOpen.values.toList();
  }

  Future<void> refreshUI() async {
    // final _categories = await getCategory();
    // income.value.clear();
    // expense.value.clear();
    // Future.forEach(_categories, (Categories category) {
    //   if (category.type == CategoryType.income) {
    //     income.value.add(category);
    //   } else {
    //     expense.value.add(category);
    //   }
    // });
  }

  deleteTransaction(int key) {
    final db_box = Hive.box<AddTransaction>(db_transaction);
    db_box.delete(key);
    refreshUI();
  }

  updateTransaction(int index, AddTransaction value) {
    final dbOpen = Hive.box<AddTransaction>(db_transaction);
    dbOpen.putAt(index, value);
    refreshUI();
  }

  clearTransactionHive() {
    final dbOpen = Hive.box<AddTransaction>(db_transaction);
    dbOpen.clear();
  }
}
