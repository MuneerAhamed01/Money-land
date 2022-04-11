import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:money_land/database/moneyland_model_class.dart';
import 'package:money_land/main.dart';
import 'package:money_land/screens/add_page/assest/styles.dart';
import 'package:money_land/screens/add_page/assest/widgets.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';

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
    _tabControl = TabController(
        length: 2,
        vsync: this,
        initialIndex: widget.editValues.isEmpty
            ? 0
            : widget.editValues["type"] == CategoryType.expense
                ? 1
                : 0);
    _tabControl.addListener(tabHandler);

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

  @override
  Widget build(BuildContext context) {
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
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: Container(
                  color: lightColor,
                  child: TabBar(
                    indicator: BoxDecoration(color: themeColor),
                    labelColor: Colors.black,
                    tabs: const [Tab(text: 'INCOME'), Tab(text: 'EXPENSE')],
                    controller: _tabControl,
                  ),
                ),
              ),
              Form(
                  key: keyAdd,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextFormField(
                            initialValue: initialValues.isEmpty
                                ? null
                                : initialValues["purpose"],
                            maxLines: 1,
                            decoration: dec(
                                _tabControl.index == 0 ? "Form" : "Purpose"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "";
                              } else {
                                name = value;
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
                          SizedBox(
                            width: double.infinity,
                            child: ValueListenableBuilder(
                                valueListenable: _tabControl.index == 0
                                    ? db_Categories.income
                                    : db_Categories.expense,
                                builder: (context,
                                    List<Categories> categoryDowm, _) {
                                  return DropdownButtonFormField<Categories>(
                                    value: _tabControl.index == 0
                                        ? itemsOf
                                        : itemsOn,
                                    hint: const Text("Select Category"),
                                    dropdownColor: Colors.white,
                                    decoration: dec(""),
                                    items: categoryDowm
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
                                  );
                                }),
                          ),
                          sizedBox(context),
                          TextFormField(
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
                            height: mediaQuery(context, 0.06),
                            child: ElevatedButton(
                              onPressed: () {
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
                    db_trans.addTransactions(AddTransaction(
                        name: name,
                        date: initialDate ?? now,
                        category: categoryOf,
                        amount: amount,
                        notes: notes,
                        type: CategoryType.income));
                  } else {
                    db_trans.addTransactions(AddTransaction(
                        name: name,
                        date: initialDate ?? now,
                        category: categoryOf,
                        amount: amount,
                        notes: notes,
                        type: CategoryType.expense));
                  }
                } else {
                  if (_tabControl.index == 0) {
                    db_trans.updateTransaction(
                        widget.editValues["key"],
                        AddTransaction(
                            name: name,
                            date: initialDate ?? now,
                            category: categoryOf,
                            amount: amount,
                            notes: notes,
                            type: CategoryType.income));
                  } else {
                    db_trans.updateTransaction(
                        widget.editValues["key"],
                        AddTransaction(
                            name: name,
                            date: initialDate ?? widget.editValues["date"],
                            category: categoryOf,
                            amount: amount,
                            notes: notes,
                            type: CategoryType.expense));
                  }
                }
                Navigator.pop(ctx);
                Navigator.pushReplacementNamed(context, '/home');
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
