import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_land/database/database_crud/db_crud_categories.dart';
import 'package:money_land/database/moneyland_model_class.dart';
import 'package:money_land/main.dart';
import 'package:money_land/screens/category_page/assest/functions.dart';
import 'package:money_land/screens/category_page/tabs/income_tab.dart';
import 'package:money_land/themes/colors/colors.dart';

import '../../../global/styles.dart';
import '../../../themes/mediaquery/mediaquery.dart';

// ignore: must_be_immutable
class Expense extends StatefulWidget {
  const Expense({Key? key}) : super(key: key);

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  @override
  void initState() {
    db_Categories.refreshUI();

    super.initState();
  }

  int? accesKey;
  @override
  Widget build(BuildContext context) {
    // final List boxOf = Hive.box<Categories>('Category').values.toList();

    return Container(
      color: Colors.white,
      child: ValueListenableBuilder(
          valueListenable: db_Categories.expense,
          builder: (context, List<Categories> exp, _) {
            return exp.isEmpty
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "lib/global/images/sentiment_very_dissatisfied.svg",
                        color: Colors.grey,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text("No category available"),
                      ),
                    ],
                  ))
                : ListView.builder(
                    // separatorBuilder: (context, index) {
                    //   return const Divider();
                    // },
                    itemBuilder: (context, index) {
                      // final expense = addExpense(box.values.toList());
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: ListTile(
                          title: Text(
                            exp[index].category!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  final int? ind =
                                      dbConnect(exp[index].category);
                                  bottomSheet(context, "Edit Expense", ind!,
                                      Creating.editing, CategoryType.expense,
                                      initial: exp[index].category);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  showPopUp(exp[index]);
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: exp.length,
                  );
          }),
    );
  }

  showPopUp(Categories delete) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(' Delete'),
        content: const Text('Are you sure'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              db_Categories.deleteCategory(delete.key);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  int? dbConnect(String? exp) {
    final db = Hive.box<Categories>(db_Name).values.toList();

    for (int i = 0; i <= db.length; i++) {
      if (db[i].category == exp) {
        accesKey = i;
        break;
      }
    }
    return accesKey;
  }
}
