import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:money_land/database/moneyland_model_class.dart';
import 'package:money_land/global/styles.dart';
import 'package:money_land/main.dart';
import 'package:money_land/screens/category_page/assest/functions.dart';

import 'package:money_land/screens/homepage/assest/functions.dart';
import 'package:money_land/screens/homepage/assest/styles.dart';
import 'package:money_land/screens/homepage/assest/widgets.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

DateTime now = DateTime.now();
String formattedDate = DateFormat(' EEE d MMM').format(now);

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _date_in_home;
  void initState() {
    _date_in_home = TabController(length: 4, vsync: this);
    _date_in_home.addListener(settings);
    super.initState();
  }

  bool visbleOf() {
    if (Hive.box<AddTransaction>(db_transaction).isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  settings() {
    setState(() {});
  }

  // ValueNotifier<bool> visible = ValueNotifier(fa);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Home",
          style: titleText(),
        ),
        backgroundColor: lightColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: Icon(
                Icons.calendar_month_outlined,
                color: themeColor,
              ),
              onPressed: () => showDate(context, _date_in_home),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: _date_in_home.index <= 2
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Wrap(
                          spacing: 0.01,
                          children: [
                            IconButton(
                                onPressed: null,
                                icon: iconOf(Icons.arrow_back_ios)),
                            // ignore: avoid_unnecessary_containers
                            Container(
                              alignment: Alignment.center,
                              child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    _date_in_home.index == 0
                                        ? formattedDate
                                        : _date_in_home.index == 1
                                            ? 'April'
                                            : '2022',
                                    style: const TextStyle(color: Colors.black),
                                  )),
                            ),
                            IconButton(
                                onPressed: null,
                                icon: iconOf(Icons.arrow_forward_ios))
                          ],
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 20, top: 12),
                      child: Row(
                        children: [
                          datePickerOfHome(formattedDate, context),
                          SizedBox(
                            width: mediaQueryWidth(context, 0.02),
                          ),
                          datePickerOfHome(formattedDate, context)
                        ],
                      ),
                    ),
              width: double.infinity,
              height: mediaQuery(context, 0.04),
              color: lightColor,
            ),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                    height: mediaQuery(context, 0.44),
                    decoration: roundedConrner(lightColor)),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: mediaQuery(context, 0.24),
                        width: double.infinity,
                        child: const Text(
                          "₹ 20,000",
                          style: TextStyle(
                              fontSize: 80, fontWeight: FontWeight.bold),
                        ),
                        decoration: roundedConrner(
                            const Color.fromARGB(156, 253, 202, 202)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: mediaQuery(context, 0.03),
                        width: mediaQueryWidth(context, 0.29),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          color: themeColor,
                        ),
                        child: const Text(
                          "Current Balance",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: -28,
                  left: 12,
                  right: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      transactionContainer(context, 'Income', '₹ 1,000'),
                      transactionContainer(context, 'Expense', '₹ 1,000')
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: mediaQuery(context, 0.05),
            ),
            Divider(),
            Visibility(
              visible: visbleOf(),
              child: Padding(
                padding: const EdgeInsets.only(left: 17.5),
                child: Text(
                  "Recent Transaction :",
                  style: boldText(17),
                ),
              ),
            ),
            ValueListenableBuilder(
                valueListenable:
                    Hive.box<AddTransaction>(db_transaction).listenable(),
                builder: (context, Box<AddTransaction> box, _) {
                  final listBox = box.values.toList();
                  if (listBox.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          Image.asset(
                            "lib/global/images/Group 8.png",
                            scale: 1.9,
                            opacity: const AlwaysStoppedAnimation(100),
                            color: themeColor,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "No transaction Found",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                    );
                  } else {
                    return ListView.separated(
                        controller: ScrollController(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final list = listBox[index];
                          return ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, '/details');
                            },
                            leading: Container(
                              alignment: Alignment.center,
                              height: mediaQuery(context, 0.05),
                              width: mediaQueryWidth(context, 0.12),
                              decoration: roundedConrnerTwo(themeColor),
                              child: Text(
                                list.type == CategoryType.income
                                    ? "INC"
                                    : "EXP",
                                style: boldText(17),
                              ),
                            ),
                            title: Text(list.name!),
                            subtitle: Text(list.date!),
                            trailing: Text(
                              "₹${list.amount}",
                              style: boldText(25),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: listBox.length);
                  }
                })
          ],
        ),
      ),
    );
  }
}
