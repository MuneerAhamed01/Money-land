import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:money_land/database/moneyland_model_class.dart';
import 'package:money_land/global/styles.dart';
import 'package:money_land/main.dart';
import 'package:money_land/screens/add_page/assest/styles.dart';
import 'package:money_land/screens/add_page/assest/widgets.dart';
import 'package:money_land/screens/category_page/assest/functions.dart';
import 'package:money_land/screens/homepage/home.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';

import 'assest/functions.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

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
    _tabControl = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabControl.addListener(tabHandler);

    super.initState();
  }

  void tabHandler() {
    setState(() {});
  }

  final keyAdd = GlobalKey<FormState>();
  final TextEditingController _date = TextEditingController(text: currrentDate);

  List<String> items = ['Loan', 'Vehicle', 'House'];
  DateTime? initialDate;
  Categories? itemsOf;
  Categories? itemsOn;

  String? selected;
  String? selectedExpense;

  String? name;
  String? dateof;
  String? categoryOf;
  String? amount;
  String? notes;

  @override
  Widget build(BuildContext context) {
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
              FormField(
                  key: keyAdd,
                  builder: ((field) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextFormField(
                                maxLines: 1,
                                decoration: dec("Name"),
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
                                      return DropdownButtonFormField<
                                          Categories>(
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
                                          if (value!.category == null ||
                                              value.category!.isEmpty) {
                                            return '';
                                          } else {
                                            value.category = categoryOf;
                                            return null;
                                          }
                                        },
                                      );
                                    }),
                              ),
                              sizedBox(context),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                decoration: dec("Amount"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              sizedBox(context),
                              TextFormField(
                                maxLines: 6,
                                decoration: dec("Notes"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "";
                                  } else {
                                    notes = value;
                                    return null;
                                  }
                                },
                              ),
                              sizedBox(context),
                              _tabControl.index == 0
                                  ? SizedBox(
                                      width: mediaQueryWidth(context, 0.25),
                                      height: mediaQuery(context, 0.06),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          print("Income");
                                        },
                                        child: Text("Save", style: styleText),
                                        style: styleButton(context),
                                      ),
                                    )
                                  : SizedBox(
                                      width: mediaQueryWidth(context, 0.25),
                                      height: mediaQuery(context, 0.06),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          print("Expense");
                                        },
                                        child: Text(
                                          'Save',
                                          style: styleText,
                                        ),
                                        style: styleButton(context),
                                      ),
                                    )
                            ],
                          ),
                        ),
                      )))
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
        // _date.text = formattedDate;
      });

      return formattedDate;
    } else {
      return _date.text;
    }
  }
}
