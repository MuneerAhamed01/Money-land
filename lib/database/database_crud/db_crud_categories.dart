import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_land/database/moneyland_model_class.dart';

String db_Name = "Categories";

class CategoryDB {
  ValueNotifier<List<Categories>> income = ValueNotifier([]);
  ValueNotifier<List<Categories>> expense = ValueNotifier([]);
  Future<void> addCategory(Categories value) async {
    final dbOpen = Hive.box<Categories>(db_Name);

    await dbOpen.add(value);
    refreshUI();
  }

  Future<List<Categories>> getCategory() async {
    final dbOpen = Hive.box<Categories>(db_Name);

    return dbOpen.values.toList();
  }

  Future<void> refreshUI() async {
    final _categories = await getCategory();
    income.value.clear();
    expense.value.clear();
    Future.forEach(_categories, (Categories category) {
      if (category.type == CategoryType.income) {
        income.value.add(category);
      } else {
        expense.value.add(category);
      }
    });
    income.notifyListeners();
    expense.notifyListeners();
  }

  deleteCategory(int key) {
    final dbOpen = Hive.box<Categories>(db_Name).delete(key);
    refreshUI();
  }

  updateCatogry(int index, Categories value) {
    final dbOpen = Hive.box<Categories>(db_Name);
    dbOpen.putAt(index, value);
    refreshUI();
  }

  clearHive() {
    final dbOpen = Hive.box<Categories>(db_Name);
    dbOpen.clear();
  }
}
