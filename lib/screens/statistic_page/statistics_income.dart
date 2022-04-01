import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_land/global/styles.dart';

import 'package:money_land/screens/add_page/assest/widgets.dart';
import 'package:money_land/screens/homepage/assest/styles.dart';
import 'package:money_land/screens/settings_page/settings.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../add_page/assest/functions.dart';
import 'assests/widgets.dart';

class StatisticIncome extends StatefulWidget {
  const StatisticIncome({Key? key}) : super(key: key);

  @override
  State<StatisticIncome> createState() => _StatisticState();
}

class _StatisticState extends State<StatisticIncome>
    with SingleTickerProviderStateMixin {
  late TabController _dateController;
  late List<Datas> chartsof;

  @override
  void initState() {
    chartsof = chartView();
    _dateController = TabController(length: 4, vsync: this, initialIndex: 0);
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

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat(' EEE d MMM').format(now);
    return SafeArea(
      child: Scaffold(
          // backgroundColor: lightColor,

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
                        "₹ 10,000",
                        style: boldText(60),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration:
                  roundedConrnerStatic(Color.fromARGB(172, 255, 240, 240)),
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
                            labelPosition: ChartDataLabelPosition.outside),
                        dataSource: chartsof,
                        xValueMapper: (Datas data, _) => data.category,
                        yValueMapper: (Datas data, _) => data.amount,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                    onTap: () => date('dd', DatePickerMode.day),
                                    child: datePickerOf("Day", context))
                                : _dateController.index == 1
                                    ? InkWell(
                                        onTap: () =>
                                            date("MM", DatePickerMode.day),
                                        child: datePickerOf('Month', context))
                                    : _dateController.index == 2
                                        ? InkWell(
                                            onTap: () => date(
                                                "YYYY", DatePickerMode.year),
                                            child:
                                                datePickerOf('year', context))
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                  onTap: () => date("dd-mm",
                                                      DatePickerMode.day),
                                                  child: datePickerOf(
                                                      "day", context)),
                                              SizedBox(
                                                width: mediaQueryWidth(
                                                    context, 0.01),
                                              ),
                                              InkWell(
                                                  onTap: () => date("dd-mm",
                                                      DatePickerMode.day),
                                                  child: datePickerOf(
                                                      "type", context))
                                            ],
                                          ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListView.separated(
                        controller: ScrollController(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
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
                                "INC",
                                style: boldText(17),
                              ),
                            ),
                            title: Text("Salary"),
                            subtitle: Text(formattedDate),
                            trailing: Text(
                              "₹ 500",
                              style: boldText(25),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: 10),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
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

  date(String format, DatePickerMode modeof) async {
    var formattedDate = await datePicker(context, format, modeof);
    setState(() {
      day = formattedDate;
    });

    // print(placedAt);
  }
}

class Datas {
  String? category;
  int? amount;

  Datas({this.amount, this.category});
}
