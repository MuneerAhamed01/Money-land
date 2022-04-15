import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:money_land/database/moneyland_model_class.dart';
import 'package:money_land/main.dart';
import 'package:money_land/screens/homepage/home.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:money_land/global/styles.dart';
import 'package:money_land/screens/homepage/assest/styles.dart';
import 'package:money_land/screens/statistic_page/assests/functions.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../global/functions/functions.dart';
import '../homepage/assest/functions.dart';
import '../homepage/assest/widgets.dart';
import 'assests/widgets.dart';

class StatisticIncome extends StatefulWidget {
  const StatisticIncome({Key? key}) : super(key: key);

  @override
  State<StatisticIncome> createState() => _StatisticState();
}

final initialDate = DateTimeRange(
    start: DateTime.now(), end: DateTime.now().add(const Duration(days: 3)));

class _StatisticState extends State<StatisticIncome>
    with SingleTickerProviderStateMixin {
  late TabController _dateController;
  late List<Datas> chartsof;

  @override
  void initState() {
    chartsof = chartView();
    _dateController = TabController(length: 4, vsync: this, initialIndex: 1);
    _dateController.addListener(Setting);
    // TODO: implement initState
    super.initState();
  }

  Setting() {
    setState(() {});
  }

  ValueNotifier<int> ontap = ValueNotifier(0);
  String day = "01";
  String month = 'month';
  String year = "year";
  DateTime monthPicker = DateTime.now();
  String? formattedMonth;
  String? formattedYear;
  String? formateDay;
  DateTimeRange range = initialDate;
  String? rangeTextStart;
  String? rangeTextEnd;

  @override
  Widget build(BuildContext context) {
    formattedMonth = DateFormat('MMM').format(monthPicker);
    formateDay = DateFormat('dd-MM-yy').format(monthPicker);
    formattedYear = DateFormat('yyyy').format(monthPicker);

    rangeTextStart = DateFormat('dd-MM-yy').format(range.start);
    rangeTextEnd = DateFormat('dd-MM-yy').format(range.end);

    List<AddTransaction> transaction =
        Hive.box<AddTransaction>(db_transaction).values.toList();
    final filteredList = gotoFilter(
        range: monthPicker,
        controller: _dateController,
        list: transaction,
        dateTimeRange: range);
    final double totalIncome =
        totalTransaction(filteredList, CategoryType.income);
    return SafeArea(
      child: ScrollConfiguration(
        behavior: const ScrollBehavior(
            androidOverscrollIndicator: AndroidOverscrollIndicator.glow),
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 238, 238),
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
                              "My Earnings :",
                              style: boldText(22),
                            ),
                            SizedBox(
                              height: mediaQuery(context, 0.02),
                            ),
                            Text(
                              "₹ $totalIncome",
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
                                          onTap: () async {
                                            monthPicker = await datePicker(
                                                context, 'dd', monthPicker);
                                            setState(() {});
                                          },
                                          child: datePickerOf(
                                              formateDay ?? "Day", context))
                                      : _dateController.index == 1
                                          ? InkWell(
                                              onTap: () async {
                                                monthPicker =
                                                    await datePickerNew(
                                                        context,
                                                        _dateController,
                                                        monthPicker);
                                                setState(() {});
                                              },
                                              child: datePickerOf(
                                                  formattedMonth ?? 'Month',
                                                  context))
                                          : _dateController.index == 2
                                              ? InkWell(
                                                  onTap: () async {
                                                    monthPicker =
                                                        await datePickerNew(
                                                            context,
                                                            _dateController,
                                                            monthPicker);
                                                    setState(() {});
                                                  },
                                                  child: datePickerOf(
                                                      formattedYear ?? "Year",
                                                      context))
                                              : Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    InkWell(
                                                        onTap: () async {
                                                          range =
                                                              await dateRangePicker(
                                                                  context,
                                                                  range);
                                                          setState(() {});
                                                        },
                                                        child: datePickerOf(
                                                            rangeTextStart ??
                                                                "From",
                                                            context)),
                                                    SizedBox(
                                                      width: mediaQueryWidth(
                                                          context, 0.01),
                                                    ),
                                                    InkWell(
                                                        onTap: () async {
                                                          range =
                                                              await dateRangePicker(
                                                                  context,
                                                                  range);
                                                          setState(() {});
                                                        },
                                                        child: datePickerOf(
                                                            rangeTextEnd ??
                                                                "To",
                                                            context))
                                                  ],
                                                ))
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ValueListenableBuilder(
                              valueListenable:
                                  Hive.box<AddTransaction>(db_transaction)
                                      .listenable(),
                              builder: (context, Box<AddTransaction> box, _) {
                                final List<AddTransaction> list =
                                    box.values.toList();
                                final List<AddTransaction> income =
                                    splitTransaction(list, CategoryType.income);
                                final filteredList = gotoFilter(
                                    controller: _dateController,
                                    dateTimeRange: range,
                                    list: income,
                                    range: monthPicker);

                                if (filteredList.isEmpty) {
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
                                        final incomeList = filteredList[index];
                                        final accessKey =
                                            getKey(list, incomeList.key!);
                                        String formattedDate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(incomeList.date!);
                                        return GestureDetector(
                                          onLongPress: () => alertDialog(
                                              incomeList.key, context),
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/editscreen',
                                                arguments: {
                                                  "date": incomeList.date,
                                                  "category":
                                                      incomeList.category,
                                                  "amount": incomeList.amount,
                                                  "notes": incomeList.notes,
                                                  "key": accessKey,
                                                  "type": incomeList.type
                                                });
                                          },
                                          child: Card(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            shadowColor: Colors.grey[350],
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  leading: Container(
                                                    alignment: Alignment.center,
                                                    height: mediaQuery(
                                                        context, 0.05),
                                                    width: mediaQueryWidth(
                                                        context, 0.12),
                                                    decoration:
                                                        roundedConrnerTwo(
                                                            themeColor),
                                                    child: Text(
                                                      incomeList.type ==
                                                              CategoryType
                                                                  .income
                                                          ? "INC"
                                                          : "EXP",
                                                      style: boldText(17),
                                                    ),
                                                  ),
                                                  title: Text(incomeList
                                                      .category!.category!),
                                                  subtitle: Text(formattedDate),
                                                  trailing: Text(
                                                    "₹${incomeList.amount}",
                                                    style: boldText(21),
                                                  ),
                                                ),
                                                const Divider(),
                                                detailsView(
                                                    15,
                                                    'Category :',
                                                    incomeList
                                                        .category!.category!),
                                                SizedBox(
                                                  height:
                                                      mediaQuery(context, 0.01),
                                                ),
                                                detailsView(16, 'Notes :',
                                                    incomeList.notes!),
                                                SizedBox(
                                                  height:
                                                      mediaQuery(context, 0.02),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          Container(
                                            height: mediaQuery(context, 0.01),
                                            width: double.infinity,
                                            color: const Color.fromARGB(
                                                255, 255, 238, 238),
                                          ),
                                      itemCount: filteredList.length);
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
      Datas(category: 'Salary', amount: 2000),
      Datas(category: 'Side Hustle', amount: 3000),
      Datas(category: 'Rent', amount: 5000),
      Datas(category: 'Buisness', amount: 500),
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
              // setState(() {});
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
