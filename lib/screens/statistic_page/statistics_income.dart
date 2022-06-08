import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:money_land/database/moneyland_model_class.dart';
import 'package:money_land/logic/transaction/transaction_bloc.dart';
import 'package:money_land/main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:money_land/global/styles.dart';
import 'package:money_land/screens/homepage/assest/styles.dart';
import 'package:money_land/screens/statistic_page/assests/functions.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';
import '../../database/database_crud/db_crud_categories.dart';
import '../../global/functions/functions.dart';
import '../../logic/datetime/datetime_cubit.dart';
import '../../logic/tabcontroller/tabcontroller_cubit.dart';
import '../homepage/assest/functions.dart';
import '../homepage/assest/widgets.dart';
import 'assests/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  // late List<Datas> chartsof;

  @override
  void initState() {
    // chartsof = chartView();
    _dateController = TabController(length: 4, vsync: this, initialIndex: 1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 238, 238),
            body: SingleChildScrollView(
              child: Builder(builder: (context) {
                context.read<DatetimeCubit>().onDate(_dateController);
                context.watch<TabcontrollerCubit>().state;
                final buildList = context.watch<TransactionBloc>().state;
                final dateList = context.watch<DatetimeCubit>().state;
                context.read<TransactionBloc>().add(GetFilteredList(
                    tabIndex: _dateController.index,
                    dateTime: dateList.dateTime!,
                    dateTimeRange: dateList.dateTimeRange!));

                //
                final filteredList = buildList.income;
                List<Data> connectedList = chartViewList(filteredList);

                return Column(
                  children: [
                    Container(
                      color: Colors.white,
                      height: mediaQuery(context, 0.18),
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
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
                                "₹ ${buildList.incomeAmunt}",
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
                          SizedBox(
                            height: mediaQuery(context, 0.35),
                            width: double.infinity,
                            child: filteredList.isEmpty
                                ? const Center(child: Text("No Data Available"))
                                : SfCircularChart(
                                    palette: [
                                      themeColor,
                                      Colors.green,
                                      Colors.amber,
                                      const Color.fromARGB(255, 8, 140, 37),
                                      const Color.fromRGBO(116, 180, 155, 1),
                                      const Color.fromRGBO(0, 168, 181, 1),
                                      const Color.fromRGBO(73, 76, 162, 1),
                                      const Color.fromRGBO(255, 205, 96, 1),
                                      const Color.fromRGBO(255, 240, 219, 1),
                                      const Color.fromRGBO(238, 238, 238, 1)
                                    ],
                                    legend: Legend(
                                      isVisible: true,
                                      position: LegendPosition.bottom,
                                    ),
                                    series: <CircularSeries>[
                                      DoughnutSeries<Data, String>(
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                                isVisible: true,
                                                labelPosition:
                                                    ChartDataLabelPosition
                                                        .outside),
                                        dataSource: connectedList,
                                        xValueMapper: (Data data, _) =>
                                            data.categories,
                                        yValueMapper: (Data data, _) =>
                                            data.amount,
                                      )
                                    ],
                                  ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 15.w),
                                child: SizedBox(
                                  width: 200.w,
                                  child: TabBar(
                                    onTap: (value) {
                                      context
                                          .read<TabcontrollerCubit>()
                                          .changeIndex(value);
                                      context
                                          .read<DatetimeCubit>()
                                          .onDate(_dateController);
                                    },
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
                              ),
                              SizedBox(
                                width:
                                    _dateController.index <= 2 ? 110.w : 54.w,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                      child: _dateController.index == 0
                                          ? InkWell(
                                              onTap: () async {
                                                context
                                                    .read<DatetimeCubit>()
                                                    .datePickerOn(context,
                                                        _dateController);
                                              },
                                              child: datePickerOf(
                                                  dateList.formatedDate!,
                                                  context))
                                          : _dateController.index == 1
                                              ? InkWell(
                                                  onTap: () async {
                                                    context
                                                        .read<DatetimeCubit>()
                                                        .datePickerOn(context,
                                                            _dateController);
                                                  },
                                                  child: datePickerOf(
                                                      dateList.formatedDate!,
                                                      context))
                                              : _dateController.index == 2
                                                  ? InkWell(
                                                      onTap: () async {
                                                        context
                                                            .read<
                                                                DatetimeCubit>()
                                                            .datePickerOn(
                                                                context,
                                                                _dateController);
                                                      },
                                                      child: datePickerOf(
                                                          dateList
                                                              .formatedDate!,
                                                          context))
                                                  : SizedBox(
                                                      width: 120.w,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          SizedBox(
                                                            width: 50.w,
                                                            child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  context
                                                                      .read<
                                                                          DatetimeCubit>()
                                                                      .dateRangPicker(
                                                                          context);
                                                                },
                                                                child: datePickerOf(
                                                                    dateList
                                                                        .formatedDateStart!,
                                                                    context)),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                mediaQueryWidth(
                                                                    context,
                                                                    0.01),
                                                          ),
                                                          SizedBox(
                                                            width: 50.w,
                                                            child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  context
                                                                      .read<
                                                                          DatetimeCubit>()
                                                                      .dateRangPicker(
                                                                          context);
                                                                },
                                                                child: datePickerOf(
                                                                    dateList
                                                                        .formatedDateEnd!,
                                                                    context)),
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                ],
                              )
                            ],
                          ),
                          const Divider(),
                          Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: filteredList.isEmpty
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 60.h),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            SvgPicture.asset(
                                                "lib/global/images/Group.svg",
                                                width: 80.w),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 13.h),
                                              child: const Text(
                                                "Add transaction to see the list",
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
                                    )
                                  : ListView.separated(
                                      controller: ScrollController(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        final incomeList = filteredList[index];
                                        final listCategory =
                                            Hive.box<Categories>(db_Name)
                                                .values
                                                .toList();
                                        final categoryKey = getKeyCategory(
                                            listCategory,
                                            incomeList.category!.category!);

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
                                                  "key": incomeList.key,
                                                  "type": incomeList.type,
                                                  "categoryKey": categoryKey
                                                });
                                          },
                                          child: Card(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10.w),
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
                                                  trailing: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        "₹${incomeList.amount}",
                                                        style: boldText(21),
                                                      ),
                                                      SizedBox(
                                                        width: mediaQueryWidth(
                                                            context, 0.02),
                                                      ),
                                                      Icon(
                                                        incomeList.type ==
                                                                CategoryType
                                                                    .income
                                                            ? Icons
                                                                .arrow_circle_up_outlined
                                                            : Icons
                                                                .arrow_circle_down,
                                                        size: 20.sp,
                                                        color:
                                                            incomeList.type ==
                                                                    CategoryType
                                                                        .income
                                                                ? Colors.green
                                                                : Colors.red,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Divider(),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10.h),
                                                  child: detailsView(
                                                      16,
                                                      'Notes :',
                                                      incomeList.notes!),
                                                ),
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
                                      itemCount: filteredList.length))
                        ],
                      ),
                    ),
                  ],
                );
              }),
            )),
      ),
    );
  }

  // changeTap() {
  //   ontap.value = _dateController.index;
  // }

  alertDialog(int key, BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
        content: const Text('You want to delete the transaction'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<TransactionBloc>().add(DeleteTransaction(key: key));
              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
