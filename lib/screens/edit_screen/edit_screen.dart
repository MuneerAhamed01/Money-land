import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_land/global/styles.dart';
import 'package:money_land/screens/add_page/assest/styles.dart';
import 'package:money_land/screens/add_page/assest/widgets.dart';
import 'package:money_land/screens/edit_screen/assest/widgets.dart';
import 'package:money_land/screens/statistic_page/assests/functions.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';

import '../add_page/assest/functions.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen>
    with SingleTickerProviderStateMixin {
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
                              textFieldsEdit('Name', 1, "Engine work"),
                              sizedBox(context),
                              TextFormField(
                                initialValue: "Fri 1 Apr",
                                readOnly: true,

                                // focusNode: AlwaysDisabledFocusNode(),
                                decoration: dec("Date"),
                                onTap: () {
                                  date();
                                },
                              ),
                              sizedBox(context),
                              Container(
                                color: Colors.white,
                                width: double.infinity,
                                child: DropdownButtonFormField<String>(
                                  dropdownColor: Colors.white,
                                  decoration: dec(""),
                                  value: selected,
                                  items: null,
                                  onChanged: (item) {
                                    setValue(item);
                                  },
                                ),
                              ),
                              sizedBox(context),
                              textFieldsEdit('Amount', 1, '500'),
                              sizedBox(context),
                              textFieldsEdit(
                                  'Notes', 6, "Engine repair of bike"),
                              sizedBox(context),
                              _tabControl.index == 0
                                  ? SizedBox(
                                      width: mediaQueryWidth(context, 0.25),
                                      height: mediaQuery(context, 0.06),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
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
                                          Navigator.pop(context);
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
        await datePicker(context, 'dd-MM-yyyy');
    setState(() {
      // _dateEditController.text = formattedDate;
    });
  }

  setValue(String? item) {
    setState(() {
      selected = item;
    });
  }
}
