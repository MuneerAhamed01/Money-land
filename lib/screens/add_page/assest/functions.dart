import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_land/main.dart';

import '../../../database/moneyland_model_class.dart';
import 'styles.dart';

List<String> incomeAdd = [];

//Date choosing start

//Date choosing end

List<String> createList(List<Categories> exp) {
  List<String> expenseDrop = [];
  for (var i = 0; i < exp.length; i++) {
    print("object");
    expenseDrop.add(exp[i].category!);
    // print(expenseDrop);
  }
  return expenseDrop;
}

categoryCreate(List<Categories> cat) {
  print("ok");
  List<String> expenseAdd = [];
  for (var i = 0; i < cat.length; i++) {
    if (cat[i].type == CategoryType.expense) {
      expenseAdd.add(cat[i].category!);
    } else {
      incomeAdd.add(cat[i].category!);
    }
  }
  return expenseAdd;
}


