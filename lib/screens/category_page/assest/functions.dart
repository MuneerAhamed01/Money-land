import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:money_land/main.dart';
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
bottomSheet(BuildContext context, String type, int index, Creating typeof,
    CategoryType dbType,
    {String? initial}) {
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
                  padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
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
                        db_Categories.addCategory(
                            Categories(category: category, type: dbType));
                        Navigator.pop(ctx);
                      } else {
                        db_Categories.updateCatogry(index,
                            Categories(category: category, type: dbType));
                        final dbUpdate =
                            Hive.box<Categories>(db_Name).get(index);
                        Navigator.pop(ctx); 

                        gotoEditCategory(initial!, dbUpdate!);
                      }
                    } else {
                      snackbarOf(ctx);
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(
                        fontSize: 20,
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
  print(listTrans[0].category);
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
