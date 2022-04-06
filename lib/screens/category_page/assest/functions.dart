import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_land/global/styles.dart';
import 'package:money_land/main.dart';
import 'package:money_land/screens/add_page/assest/styles.dart';
import 'package:money_land/screens/add_page/assest/widgets.dart';
import 'package:money_land/screens/category_page/assest/styles.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';

import '../../../database/database_crud/db_crud_categories.dart';
import '../../../database/moneyland_model_class.dart';

enum Creating { adding, editing }

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
                      padding:
                          const EdgeInsets.only(top: 60, left: 20, right: 20),
                      child: Form(
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: key,
                        child: TextFormField(
                            initialValue:
                                typeof == Creating.adding ? null : initial,
                            decoration: dec(type),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Entered value is empty";
                              } else if (showDuplicate(value, initial)) {
                                return 'The Category already exist';
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
                              Navigator.pop(ctx);
                            }
                          }
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))
                  ],
                ),
              )),
        );
      });
}

bool showDuplicate(String value, String? initial) {
  final db = Hive.box<Categories>(db_Name).values.toList();
  int flag = 0;
  if (initial != value) {
    if (db.isNotEmpty) {
      for (int i = 0; i <= db.length - 1; i++) {
        if (db[i].category == value) {
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
