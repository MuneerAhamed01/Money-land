import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_land/main.dart';
import 'package:money_land/logic/category/category_bloc.dart';
import 'package:money_land/screens/add_page/assest/styles.dart';
import 'package:money_land/screens/add_page/assest/widgets.dart';
import 'package:money_land/screens/category_page/assest/styles.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';

import '../../../database/database_crud/db_crud_categories.dart';
import '../../../database/moneyland_model_class.dart';

enum Creating { adding, editing }
String typeOfText = '';

String? category;
final key = GlobalKey<FormState>();
final box = Hive.box<Categories>('Category');
bottomSheet(
    {required BuildContext context,
    required String type,
    int? index,
    required Creating typeof,
    required CategoryType dbType,
    String? initial}) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return SizedBox(
        height: mediaQuery(context, 0.50),
        child: Container(
          decoration: roundedConrnerCatgory(lightColor),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 60.h, left: 20.w, right: 20.w),
                  child: Form(
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: key,
                    child: TextFormField(
                        initialValue:
                            typeof == Creating.adding ? null : initial,
                        decoration: dec(type),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            typeOfText = 'Entered value is empty';
                            return "";
                          } else if (showDuplicate(value, initial)) {
                            typeOfText = 'The category is already available';
                            return '';
                          } else {
                            category = value;
                            return null;
                          }
                        }),
                  ),
                ),
                sizedBox(context),
                ElevatedButton(
                  style: styleButtonBottom(ctx),
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      if (typeof == Creating.adding) {
                        final categoriesAdd =
                            Categories(category: category, type: dbType);
                        context
                            .read<CategoryBloc>()
                            .add(AddCategory(list: categoriesAdd));

                        Navigator.pop(ctx);
                      } else {
                        final updateCategory =
                            Categories(category: category, type: dbType);

                        context.read<CategoryBloc>().add(
                            EditCategory(key: index!, list: updateCategory));
                        // final dbUpdate =
                        //     Hive.box<Categories>(db_Name).get(index);
                        Navigator.pop(ctx);

                        // gotoEditCategory(initial!, dbUpdate!);
                      }
                    } else {
                      snackbarOf(ctx);
                    }
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

bool showDuplicate(String value, String? initial) {
  final db = Hive.box<Categories>(db_Name).values.toList();
  int flag = 0;
  if (initial != value) {
    if (db.isNotEmpty) {
      for (int i = 0; i <= db.length - 1; i++) {
        if (db[i].category!.toLowerCase().trim() ==
            value.toLowerCase().trim()) {
          flag = 1;
          break;
        }
      }
    }
    if (flag == 1) {
      return true;
    } else {
      return false;
    }
  }
  return false;
}

snackbarOf(BuildContext context) {
  final snackBar = SnackBar(
    content: Text(typeOfText),
    backgroundColor: Colors.grey[600],
    // padding: EdgeInsets.all(10),

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    behavior: SnackBarBehavior.floating,
  );
  Navigator.pop(context);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

categorySelector(List<AddTransaction> listTrans, Categories categories) {
  for (var i = 0; i < listTrans.length; i++) {
    if (listTrans[i].category!.category == categories.category) {
      final deleteTrans = listTrans[i].key;
      db_trans.deleteTransaction(deleteTrans);
    }
  }
}

gotoEditCategory(String initial, Categories categories) {
  final hiveList = Hive.box<AddTransaction>(db_transaction);
  final listTrans = hiveList.values.toList();

  for (var i = 0; i < listTrans.length; i++) {
    if (listTrans[i].category!.category == initial) {
      hiveList.putAt(
          listTrans[i].key,
          AddTransaction(
              category: categories,
              date: listTrans[i].date,
              amount: listTrans[i].amount,
              notes: listTrans[i].notes,
              type: listTrans[i].type));
    }
  }
}

gotoDelete(Categories categories) {
  final hive = Hive.box<AddTransaction>(db_transaction);

  final List<AddTransaction> list = hive.values.toList();

  for (var i = 0; i < list.length; i++) {
    if (list[i].category!.category!.toLowerCase().trim() ==
        categories.category!.toLowerCase().trim()) {
      hive.put(
          list[i].key,
          AddTransaction(
              visible: true,
              date: list[i].date,
              amount: list[i].amount,
              category: list[i].category,
              notes: list[i].notes,
              type: list[i].type));
    }
  }
}

gotoSearch(String value) {
  final hive = Hive.box<AddTransaction>(db_transaction);
  final hiveList = hive.values.toList();

  for (var i = 0; i < hiveList.length; i++) {
    if (hiveList[i].category!.category!.toLowerCase().trim() ==
        value.toLowerCase().trim()) {
      hiveList[i].category!.category = value;
      hive.put(
          hiveList[i].key,
          AddTransaction(
              visible: false,
              date: hiveList[i].date,
              amount: hiveList[i].amount,
              category: hiveList[i].category,
              notes: hiveList[i].notes,
              type: hiveList[i].type));
    }
  }
}

List<Categories> seperateCategory(CategoryType type, List<Categories> list) {
  List<Categories> incomeList = [];

  for (var item in list) {
    if (item.type == type) {
      incomeList.add(item);
    }
  }

  return incomeList;
}
