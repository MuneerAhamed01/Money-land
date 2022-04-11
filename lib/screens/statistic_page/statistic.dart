import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:money_land/database/moneyland_model_class.dart';
import 'package:money_land/global/styles.dart';
import 'package:money_land/main.dart';

import 'package:money_land/screens/homepage/assest/styles.dart';

import 'package:money_land/screens/statistic_page/assests/functions.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../homepage/assest/functions.dart';
import 'assests/widgets.dart';

class Statistic extends StatefulWidget {
  const Statistic({Key? key}) : super(key: key);

  @override
  State<Statistic> createState() => _StatisticState();
}

class _StatisticState extends State<Statistic>
    with SingleTickerProviderStateMixin {
  late TabController _dateController;
  late List<Datas> chartsof;

  @override
  void initState() {
    chartsof = chartView();
    _dateController = TabController(length: 4, vsync: this, initialIndex: 0);
    _dateController.addListener(Setting);

    super.initState();
  }

  Setting() {
    setState(() {});
  }

  ValueNotifier<int> ontap = ValueNotifier(0);
  String day = "01";
  String month = 'month';
  String year = "year";
  List<AddTransaction> transaction =
      Hive.box<AddTransaction>(db_transaction).values.toList();

  @override
  Widget build(BuildContext context) {
    final double totalExp = totalTransaction(transaction, CategoryType.expense);

    return SafeArea(
      child: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 238, 238),
            extendBody: true,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    height: mediaQuery(context, 0.18),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My Spendings :",
                              style: boldText(22),
                            ),
                            SizedBox(
                              height: mediaQuery(context, 0.02),
                            ),
                            Text(
                              "₹ $totalExp",
                              style: boldText(60),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: roundedConrnerStatic(
                        const Color.fromARGB(255, 255, 238, 238)),
                    // height: mediaQuery(context, 1),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SfCircularChart(
                          legend: Legend(
                            isVisible: true,
                            position: LegendPosition.bottom,
                          ),
                          series: <CircularSeries>[
                            DoughnutSeries<Datas, String>(
                              dataLabelSettings: const DataLabelSettings(
                                  isVisible: true,
                                  labelPosition:
                                      ChartDataLabelPosition.outside),
                              dataSource: chartsof,
                              xValueMapper: (Datas data, _) => data.category,
                              yValueMapper: (Datas data, _) => data.amount,
                            )
                          ],
                        ),
                        Padding(
                          padding: _dateController.index <= 2
                              ? const EdgeInsets.symmetric(horizontal: 20)
                              : const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TabBar(
                                  labelColor: Colors.black,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicator: circleDate(themeColor),
                                  tabs: const [
                                    Tab(text: 'D'),
                                    Tab(text: 'M'),
                                    Tab(text: 'Y'),
                                    Tab(text: 'P'),
                                  ],
                                  controller: _dateController,
                                ),
                              ),
                              SizedBox(
                                width: mediaQueryWidth(context, 0.25),
                              ),
                              Container(
                                  child: _dateController.index == 0
                                      ? InkWell(
                                          onTap: () => datePicker(
                                                context,
                                                'dd',
                                              ),
                                          child: datePickerOf("Day", context))
                                      : _dateController.index == 1
                                          ? InkWell(
                                              onTap: () =>
                                                  datePicker(context, "MM"),
                                              child: datePickerOf(
                                                  'Month', context))
                                          : _dateController.index == 2
                                              ? InkWell(
                                                  onTap: () => datePicker(
                                                      context, "year"),
                                                  child: datePickerOf(
                                                      'year', context))
                                              : Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    InkWell(
                                                        onTap: () => datePicker(
                                                            context, "yyyy"),
                                                        child: datePickerOf(
                                                            "day", context)),
                                                    SizedBox(
                                                      width: mediaQueryWidth(
                                                          context, 0.01),
                                                    ),
                                                    InkWell(
                                                        onTap: () => datePicker(
                                                            context, "yyyy"),
                                                        child: datePickerOf(
                                                            "type", context))
                                                  ],
                                                ))
                            ],
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 20, right: 20),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ValueListenableBuilder(
                              valueListenable:
                                  Hive.box<AddTransaction>(db_transaction)
                                      .listenable(),
                              builder: (context, Box<AddTransaction> box, _) {
                                final List<AddTransaction> list =
                                    box.values.toList();
                                final List<AddTransaction> expense =
                                    splitTransaction(
                                        list, CategoryType.expense);

                                if (expense.isEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 60),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            "lib/global/images/Group 8.png",
                                            scale: 1.9,
                                            opacity:
                                                const AlwaysStoppedAnimation(
                                                    100),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                      ),
                                    ),
                                  );
                                } else {
                                  return ListView.separated(
                                      controller: ScrollController(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        final expenseList = expense[index];
                                        String formattedDate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(expenseList.date!);
                                        final accessKey =
                                            getKey(list, expenseList.name!);
                                        return ListTile(
                                          onLongPress: () => alertDialog(
                                              expenseList.key, context),
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/details',
                                                arguments: {
                                                  "purpose": expenseList.name,
                                                  "date": expenseList.date,
                                                  "category":
                                                      expenseList.category,
                                                  "amount": expenseList,
                                                  "notes": expenseList.notes,
                                                  "key": accessKey,
                                                  "type": expenseList.type
                                                });
                                          },
                                          leading: Container(
                                            alignment: Alignment.center,
                                            height: mediaQuery(context, 0.05),
                                            width:
                                                mediaQueryWidth(context, 0.12),
                                            decoration:
                                                roundedConrnerTwo(themeColor),
                                            child: Text(
                                              "EXP",
                                              style: boldText(17),
                                            ),
                                          ),
                                          title: Text(expenseList.name!),
                                          subtitle: Text(formattedDate),
                                          trailing: Text(
                                            "₹ ${expenseList.amount}",
                                            style: boldText(25),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const Divider(),
                                      itemCount: expense.length);
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  List<Datas> chartView() {
    final List<Datas> charts = [
      Datas(category: 'Loan', amount: 2000),
      Datas(category: 'Vehicle', amount: 3000),
      Datas(category: 'House', amount: 5000),
      Datas(category: 'Hotel', amount: 500),
    ];
    return charts;
  }

  changeTap() {
    ontap.value = _dateController.index;
  }

  alertDialog(int key, BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        // contentPadding: EdgeInsets.only(left: 20),
        content: const Text('You want to delete the transaction'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              db_trans.deleteTransaction(key);
              Navigator.pop(context, 'OK');
              setState(() {});
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class Datas {
  String? category;
  int? amount;

  Datas({this.amount, this.category});
}
