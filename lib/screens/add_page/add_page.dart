import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_land/database/database_crud/db_crud_categories.dart';
import 'package:money_land/database/moneyland_model_class.dart';
import 'package:money_land/logic/category/category_bloc.dart';
import 'package:money_land/logic/transaction/transaction_bloc.dart';
import 'package:money_land/main.dart';
import 'package:money_land/screens/add_page/assest/styles.dart';
import 'package:money_land/screens/add_page/assest/widgets.dart';
import 'package:money_land/screens/bottom_nav/navbar.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../category_page/assest/functions.dart';

class AddPage extends StatefulWidget {
  final Map editValues;
  const AddPage({
    Key? key,
    required this.editValues,
  }) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

DateTime now = DateTime.now();
String currrentDate = DateFormat('dd-MM-yyyy').format(now);

class _AddPageState extends State<AddPage> with SingleTickerProviderStateMixin {
  late TabController _tabControl;

  @override
  void initState() {
    db_Categories.refreshUI();
    if (widget.editValues.isEmpty) {
      _tabControl = TabController(
        length: 2,
        vsync: this,
      );
      _tabControl.addListener(tabHandler);
    }

    super.initState();
  }

  void tabHandler() {
    setState(() {});
  }

  String editDate = DateFormat('dd-MM-yyyy').format(now);
  final keyAdd = GlobalKey<FormState>();

  final TextEditingController _date = TextEditingController();

  // final TextEditingController _edit = TextEditingController(text: currrentDate);

  String? selected;
  String? selectedExpense;
  String? name;
  String? dateof;
  Categories? categoryOf;
  double? amount;
  String? notes;
  DateTime? initialDate;
  Categories? itemsOf;
  Categories? itemsOn;
  Categories? itemIn;

  @override
  Widget build(BuildContext context) {
    itemIn =
        Hive.box<Categories>(db_Name).get(widget.editValues["categoryKey"]);

    final Map initialValues = widget.editValues;
    if (_date.text.isEmpty) {
      if (initialValues.isEmpty) {
        _date.text = currrentDate;
      } else {
        String initialDateEdit =
            DateFormat("dd-MM-yyyy").format(initialValues["date"]);
        _date.text = initialDateEdit;
      }
    }

    return SafeArea(
      top: widget.editValues.isEmpty ? true : false,
      child: Scaffold(
        backgroundColor: realWhite,
        appBar: widget.editValues.isNotEmpty
            ? AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                backgroundColor: lightColor,
                shadowColor: Colors.transparent,
                title: Text(
                  widget.editValues["type"] == CategoryType.income
                      ? "INCOME"
                      : "EXPENSE",
                  style: const TextStyle(color: Colors.black),
                ),
                centerTitle: true,
              )
            : null,
        body: SingleChildScrollView(
          child: Column(
            children: [
              widget.editValues.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(25),
                      child: Container(
                        color: lightColor,
                        child: TabBar(
                          indicator: BoxDecoration(color: themeColor),
                          labelColor: Colors.black,
                          tabs: const [
                            Tab(text: 'INCOME'),
                            Tab(text: 'EXPENSE')
                          ],
                          controller: _tabControl,
                        ),
                      ),
                    )
                  : const Text(""),
              Form(
                  key: keyAdd,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            // maxLength: 6,

                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6),
                              FilteringTextInputFormatter.digitsOnly
                            ],

                            initialValue: initialValues.isEmpty
                                ? null
                                : initialValues["amount"].toString(),
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            decoration: dec("Amount"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "";
                              } else {
                                final valueInt = double.parse(value);
                                amount = valueInt;
                                return null;
                              }
                            },
                          ),
                          sizedBox(context),
                          TextFormField(
                            controller: _date,
                            readOnly: true,
                            decoration: dec("Date"),
                            onTap: () async {
                              final formatteddate = await datePicker();
                              _date.text = formatteddate;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              } else {
                                dateof = value;
                                return null;
                              }
                            },
                          ),
                          sizedBox(context),
                          BlocBuilder<CategoryBloc, CategoryState>(
                            builder: (context, state) {
                              state as CategoryInitial;
                              final splitCategoryExpense = seperateCategory(
                                  CategoryType.expense, state.categoriesList);
                                   final splitCategoryIncome = seperateCategory(
                                  CategoryType.income, state.categoriesList);
                              // final inc = seperateCategory(CategoryType.income, state.categoriesList);
                              // final exp = seperateCategory(CategoryType.expense, state.categoriesList);
                              return SizedBox(
                                  width: double.infinity,
                                  child: widget.editValues.isEmpty
                                      ? DropdownButtonFormField<Categories>(
                                          value: _tabControl.index == 0
                                              ? itemsOf
                                              : itemsOn,
                                          hint: const Text("Select Category"),
                                          dropdownColor: Colors.white,
                                          decoration: dec(""),
                                          items: _tabControl.index == 0?splitCategoryIncome
                                              .map((Categories item) =>
                                                  DropdownMenuItem<Categories>(
                                                    value: item,
                                                    child: Text(item.category!),
                                                  ))
                                              .toList():splitCategoryExpense
                                              .map((Categories item) =>
                                                  DropdownMenuItem<Categories>(
                                                    value: item,
                                                    child: Text(item.category!),
                                                  ))
                                              .toList(),
                                          onChanged: (item) {
                                            if (_tabControl.index == 0) {
                                              setState(() {
                                                itemsOf = item!;
                                              });
                                            } else {
                                              setState(() {
                                                itemsOn = item!;
                                              });
                                            }
                                          },
                                          isExpanded: true,
                                          validator: (value) {
                                            if (value == null ||
                                                value.category!.isEmpty) {
                                              return '';
                                            } else {
                                              categoryOf = value;
                                              return null;
                                            }
                                          },
                                        )
                                      : DropdownButtonFormField<Categories>(
                                          hint: const Text("Select Category"),
                                          value: itemIn,
                                          dropdownColor: Colors.white,
                                          decoration: dec(""),
                                          items: 

                                          initialValues["type"] == CategoryType.income?
                                          
                                          
                                          splitCategoryIncome
                                              .map((Categories item) =>
                                                  DropdownMenuItem<Categories>(
                                                    value: item,
                                                    child: Text(item.category!),
                                                  ))
                                              .toList(): splitCategoryExpense
                                              .map((Categories item) =>
                                                  DropdownMenuItem<Categories>(
                                                    value: item,
                                                    child: Text(item.category!),
                                                  ))
                                              .toList(),
                                          onChanged: (item) {
                                            setState(() {
                                              itemIn = item!;
                                            });
                                          },
                                          isExpanded: true,
                                          validator: (value) {
                                            if (value == null ||
                                                value.category!.isEmpty) {
                                              return '';
                                            } else {
                                              categoryOf = value;
                                              return null;
                                            }
                                          },
                                        ));
                            },
                          ),
                          sizedBox(context),
                          initialValues.isEmpty
                              ? SizedBox(
                                  height: 60.h,
                                  child: Row(
                                    children: [
                                      const Text("OR"),
                                      SizedBox(
                                        height: mediaQuery(context, 0.04),
                                        child: TextButton(
                                            onPressed: () {
                                              bottomSheet(
                                                  context: context,
                                                  type: _tabControl.index == 0
                                                      ? "Add Inocme"
                                                      : "Add Expense",
                                                  typeof: Creating.adding,
                                                  dbType: _tabControl.index == 0
                                                      ? CategoryType.income
                                                      : CategoryType.expense);
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.add_box_rounded,
                                                  size: 15.sp,
                                                  color: Colors.red,
                                                ),
                                                SizedBox(
                                                  width: mediaQueryWidth(
                                                      context, 0.02),
                                                ),
                                                const Text(
                                                  "Add Category",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                )
                              : sizedBox(context),
                          TextFormField(
                              maxLength: 20,
                              initialValue: initialValues.isEmpty
                                  ? null
                                  : initialValues["notes"],
                              maxLines: 6,
                              decoration: dec("Notes"),
                              validator: (value) {
                                if (value == null) {
                                  return '';
                                } else {
                                  notes = value;
                                  return null;
                                }
                              }),
                          sizedBox(context),
                          SizedBox(
                            width: mediaQueryWidth(context, 0.25),
                            height: mediaQuery(context, 0.05),
                            child: ElevatedButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                gotoAdd();
                              },
                              child: Text("Save", style: styleText),
                              style: styleButton(context),
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  setValue(Categories? item, int controller) {}

  Future<String> datePicker() async {
    DateTime? date;

    date = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDatePickerMode: DatePickerMode.day,
        context: context,
        initialDate: initialDate ?? now,
        firstDate: DateTime(now.year - 5),
        lastDate: DateTime(now.year + 5));
    if (date != null) {
      String formattedDate = DateFormat("dd-MM-yyyy").format(date);
      setState(() {
        initialDate = date;
      });

      return formattedDate;
    } else {
      return _date.text;
    }
  }

  gotoAdd() {
    if (keyAdd.currentState!.validate()) {
      showDialog<String>(
        context: context,
        builder: (BuildContext ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // contentPadding: EdgeInsets.only(left: 20),
          content: Text(widget.editValues.isEmpty
              ? 'Do you want to save the Transaction'
              : 'Save the Changes'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(ctx, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (widget.editValues.isEmpty) {
                  if (_tabControl.index == 0) {
                    final addTransactionIncome = AddTransaction(
                        date: initialDate ?? now,
                        category: categoryOf,
                        amount: amount,
                        notes: notes,
                        type: CategoryType.income);
                    context
                        .read<TransactionBloc>()
                        .add(AddTrans(transaction: addTransactionIncome));
              
                  } else {
                    final addTransactionExpense = AddTransaction(
                        date: initialDate ?? now,
                        category: categoryOf,
                        amount: amount,
                        notes: notes,
                        type: CategoryType.expense);
                    context
                        .read<TransactionBloc>()
                        .add(AddTrans(transaction: addTransactionExpense));
                 
                  }
                } else {
                  final key = widget.editValues["key"];
                  final listBody = AddTransaction(
                      date: initialDate ?? now,
                      category: categoryOf,
                      amount: amount,
                      notes: notes,
                      type: widget.editValues["type"]);

                  context
                      .read<TransactionBloc>()
                      .add(EditEvent(key: key, transaction: listBody));
                }

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx) =>  NavBar()),
                    (route) => false);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      final snackBar = SnackBar(
        content: const Text(
          " Fill the transaction details",
        ),
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(10),
        backgroundColor: Colors.grey[600],
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  String initialValueOfDate() {
    if (widget.editValues.isEmpty) {
      return currrentDate;
    } else {
      final showEditInitial = widget.editValues[1];

      String initDate = DateFormat("dd-MM-yyyy").format(showEditInitial);
      return initDate;
    }
  }
}
