import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_land/global/styles.dart';
import 'package:money_land/screens/add_page/assest/styles.dart';
import 'package:money_land/screens/add_page/assest/widgets.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';

import 'assest/functions.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> with SingleTickerProviderStateMixin {
  late TabController _tabControl;

  @override
  void initState() {
    _tabControl = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabControl.addListener(tabHandler);
    // TODO: implement initState
    super.initState();
  }

  void tabHandler() {
    setState(() {});
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  List<String> items = ['Loan', 'Vehicle', 'House'];
  String? selected = 'Loan';

  // String formattedDate = DateFormat(' EEE d MMM').format(date!);

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
                  builder: ((field) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              textFields(_nameController, 'Name', 1),
                              sizedBox(context),
                              TextFormField(
                                readOnly: true,
                                controller: _dateController,
                                // focusNode: AlwaysDisabledFocusNode(),
                                decoration: dec("Date"),
                                onTap: () {
                                  date();
                                },
                              ),
                              sizedBox(context),
                              SizedBox(
                                width: double.infinity,
                                child: DropdownButtonFormField<String>(
                                  dropdownColor: Colors.white,
                                  decoration: dec(""),
                                  value: selected,
                                  items: category(selected, items),
                                  onChanged: (item) {
                                    setValue(item);
                                  },
                                ),
                              ),
                              sizedBox(context),
                              textFields(_amountController, 'Amount', 1),
                              sizedBox(context),
                              textFields(_notesController, 'Notes', 6),
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

  date() async {
    var formattedDate =
        await datePicker(context, 'dd-MM-yyyy', DatePickerMode.day);
    setState(() {
      _dateController.text = formattedDate;
    });
  }

  setValue(String? item) {
    setState(() {
      selected = item;
    });
  }
}
