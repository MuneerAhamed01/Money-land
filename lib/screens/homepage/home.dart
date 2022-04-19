import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:money_land/database/database_crud/db_crud_categories.dart';
import 'package:money_land/database/moneyland_model_class.dart';
import 'package:money_land/global/styles.dart';
import 'package:money_land/main.dart';
import 'package:money_land/screens/add_page/assest/widgets.dart';
import 'package:money_land/screens/homepage/assest/functions.dart';
import 'package:money_land/screens/homepage/assest/styles.dart';
import 'package:money_land/screens/homepage/assest/widgets.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';
import '../../global/functions/functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

DateTime now = DateTime.now();
String formattedDate = DateFormat(' EEE d MMM').format(now);
final initialDate = DateTimeRange(
    start: DateTime.now(), end: DateTime.now().add(const Duration(days: 3)));

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _datecontrollr;

  @override
  void initState() {
    _datecontrollr = TabController(length: 4, vsync: this, initialIndex: 1);
    _datecontrollr.addListener(settings);

    super.initState();
    rangeTextStart = formatPeriodStart(range);
    rangeTextEnd = formatPeriodEnd(range);
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

  num? totalExp;
  double? totalIncome;
  DateTime dateInRange = now;
  String? dateInRangeFormated;
  DateTimeRange? rangeOfPeriod;
  DateTimeRange range = initialDate;
  late String rangeTextStart;
  late String rangeTextEnd;

  // ValueNotifier<bool> visible = ValueNotifier(fa);

  @override
  Widget build(BuildContext context) {
    List<AddTransaction> transaction =
        Hive.box<AddTransaction>(db_transaction).values.toList();
    dateInRangeFormated = formatted();

    final filteredList = gotoFilter(
        range: dateInRange,
        controller: _datecontrollr,
        list: transaction,
        dateTimeRange: range);

    totalExp = totalTransaction(filteredList, CategoryType.expense);
    totalIncome = totalTransaction(filteredList, CategoryType.income);

    return Scaffold(
      backgroundColor: homeScaffoldBackground,
      appBar: AppBar(
        shadowColor: transparent,
        centerTitle: true,
        title: Text(
          "Home",
          style: titleText(),
        ),
        backgroundColor: lightColor,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5.w),
            child: IconButton(
              icon: Icon(
                Icons.calendar_month_outlined,
                color: themeColor,
              ),
              onPressed: () => showDate(context, _datecontrollr),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: _datecontrollr.index <= 2
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Wrap(
                          spacing: 0.01,
                          children: [
                            IconButton(
                                onPressed: () {
                                  dateInRange = decreseingDate(
                                      _datecontrollr, dateInRange);
                                  setState(() {});
                                },
                                icon: iconOf(Icons.arrow_back_ios)),
                            // ignore: avoid_unnecessary_containers
                            Container(
                              alignment: Alignment.center,
                              child: TextButton(
                                  onPressed: () async {
                                    dateInRange = await datePicker();
                                    setState(() {});
                                  },
                                  child: Text(
                                    dateInRangeFormated!,
                                    style: TextStyle(color: realBlack),
                                  )),
                            ),
                            IconButton(
                                onPressed: () {
                                  dateInRange = increasingDate(
                                      _datecontrollr, dateInRange);
                                  setState(() {});
                                },
                                icon: iconOf(
                                  Icons.arrow_forward_ios,
                                ))
                          ],
                        ),
                      ],
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: 20.w, top: 12.h),
                      child: Row(
                        children: [
                          datePickerOfHome(0, context, rangeOfPeriod),
                          SizedBox(
                            width: mediaQueryWidth(context, 0.02),
                          ),
                          datePickerOfHome(1, context, rangeOfPeriod)
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
                      EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: mediaQuery(context, 0.24),
                        width: double.infinity,
                        child: Text(
                          totalIncome! > totalExp!
                              ? '₹${totalIncome! - totalExp!}'
                              : "₹ 0.00",
                          style: TextStyle(
                              fontSize: 55.sp, fontWeight: FontWeight.bold),
                        ),
                        decoration: roundedConrner(currentBalanceHome),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: mediaQuery(context, 0.03),
                        width: mediaQueryWidth(context, 0.29),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r)),
                          color: themeColor,
                        ),
                        child: Text(
                          dateInRange == now ? "Current Balance" : "Balance",
                          style: TextStyle(fontSize: 14.sp, color: realWhite),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: -28.h,
                  left: 9.w,
                  right: 8.w,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      transactionContainer(context, 'Income', '₹ $totalIncome'),
                      transactionContainer(
                        context,
                        'Expense',
                        '₹ $totalExp',
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: mediaQuery(context, 0.05),
            ),
            const Divider(),
            Visibility(
              visible: visbleOf(),
              child: Padding(
                padding: EdgeInsets.only(left: 17.5.w),
                child: Text(
                  "Your Transaction :",
                  style: boldText(17.sp),
                ),
              ),
            ),
            sizedBox(context),
            ValueListenableBuilder(
                valueListenable:
                    Hive.box<AddTransaction>(db_transaction).listenable(),
                builder: (context, Box<AddTransaction> box, _) {
                  final listBox = box.values.toList();
                  final List<AddTransaction> listOf = gotoFilter(
                      controller: _datecontrollr,
                      range: dateInRange,
                      list: listBox,
                      dateTimeRange: range);

                  // transaction.value = filteredBox;

                  if (listOf.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 60.h),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(
                              "lib/global/images/Group 8.png",
                              scale: 1.9,
                              opacity: const AlwaysStoppedAnimation(100),
                              color: themeColor,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: const Text(
                                "No transaction Found",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                      ),
                    );
                  } else {
                    return ListView.separated(
                        controller: ScrollController(),
                        shrinkWrap: true,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final list = listOf[index];

                          final listCategory =
                              Hive.box<Categories>(db_Name).values.toList();
                          final categoryKey = getKeyCategory(
                              listCategory, list.category!.category!);

                          String formattedDate =
                              DateFormat("dd-MM-yyyy").format(list.date!);
                          return GestureDetector(
                            onLongPress: () => alertDialog(list.key, context),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/editscreen',
                                arguments: {
                                  "date": list.date,
                                  "category": list.category,
                                  "amount": list.amount,
                                  "notes": list.notes,
                                  "key": list.key,
                                  "type": list.type,
                                  "categoryKey": categoryKey
                                },
                              );
                            },
                            child: Card(
                              margin: EdgeInsets.symmetric(horizontal: 11.w),
                              shadowColor: realGrey350,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Container(
                                      alignment: Alignment.center,
                                      height: mediaQuery(context, 0.05),
                                      width: mediaQueryWidth(context, 0.12),
                                      decoration: roundedConrnerTwo(themeColor),
                                      child: Text(
                                        list.type == CategoryType.income
                                            ? "INC"
                                            : "EXP",
                                        style: boldText(17.sp),
                                      ),
                                    ),
                                    title: Text(list.category!.category!),
                                    subtitle: Text(formattedDate),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "₹${list.amount}",
                                          style: boldText(21.sp),
                                        ),
                                        SizedBox(
                                          width: mediaQueryWidth(context, 0.02),
                                        ),
                                        Icon(
                                          list.type == CategoryType.income
                                              ? Icons.arrow_circle_up_outlined
                                              : Icons.arrow_circle_down,
                                          size: 20.sp,
                                          color:
                                              list.type == CategoryType.income
                                                  ? realGreen
                                                  : realRed,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child:
                                        detailsView(16, 'Notes :', list.notes!),
                                  ),
                                  SizedBox(
                                    height: mediaQuery(context, 0.02),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Container(
                              height: mediaQuery(context, 0.01),
                              width: double.infinity,
                              color: listSeperator,
                            ),
                        itemCount: listOf.length);
                  }
                })
          ],
        ),
      ),
    );
  }

  alertDialog(int key, BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
        // contentPadding: EdgeInsets.only(left: 20),
        content: Text('You want to delete the transaction'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              db_trans.deleteTransaction(key);
              Navigator.pop(context, 'OK');
              setState(() {});
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<DateTime> datePicker() async {
    DateTime? date;

    date = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDatePickerMode: DatePickerMode.day,
        context: context,
        initialDate: now,
        firstDate: DateTime(now.year - 5),
        lastDate: DateTime(now.year + 5));
    if (date != null) {
      return date;
    } else {
      return now;
    }
  }

  String? formatted() {
    String? formattedOf;
    if (_datecontrollr.index == 0) {
      formattedOf = DateFormat('dd MMM yy').format(dateInRange);
    } else if (_datecontrollr.index == 1) {
      formattedOf = DateFormat('MMMM yyyy').format(dateInRange);
    } else {
      formattedOf = DateFormat('yyyy').format(dateInRange);
    }
    return formattedOf;
  }

  Widget datePickerOfHome(
      int type, BuildContext context, DateTimeRange? dateTimeRange) {
    return InkWell(
      onTap: () async {
        range = await dateRangePicker(context, dateTimeRange);

        setState(() {});
        rangeTextStart = formatPeriodStart(range);
        rangeTextEnd = formatPeriodEnd(range);
      },
      child: Container(
        alignment: Alignment.center,
        height: mediaQuery(context, 0.03),
        width: mediaQueryWidth(context, 0.20),
        decoration: roundedConrnerHome(lightColor),
        child: Text(
          type == 0 ? rangeTextStart : rangeTextEnd,
          style: TextStyle(
            color: realBlack,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
