import 'package:flutter/material.dart';
import 'package:money_land/database/moneyland_model_class.dart';
import 'package:money_land/global/styles.dart';
import 'package:money_land/screens/category_page/assest/functions.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'tabs/expense_tab.dart';
import 'tabs/income_tab.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;
  @override
  void initState() {
    _tabcontroller = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabcontroller.addListener(handleIndex);
    
    super.initState();
  }

  void handleIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "CATEGORIES",
            style: titleText(),
          ),
          shadowColor: Colors.transparent,
          backgroundColor: lightColor,
          bottom: TabBar(
            indicatorWeight: 1,
            controller: _tabcontroller,
            tabs: const [
              Tab(
                text: 'INCOME',
              ),
              Tab(
                text: 'EXPENSE',
              )
            ],
            indicatorColor: Colors.black,
            labelColor: Colors.black,
          ),
        ),
        body: TabBarView(
          controller: _tabcontroller,
          children: const [Income(), Expense()],
        ),
        floatingActionButton: _tabcontroller.index == 0
            ? FloatingActionButton(
                backgroundColor: themeColor,
                onPressed: () {
                  bottomSheet(
                      context: context,
                      dbType: CategoryType.income,
                      type: "Add Income",
                      typeof: Creating.adding);
                  // addPage(box);
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              )
            : FloatingActionButton(
                backgroundColor: themeColor,
                onPressed: () {
                  bottomSheet(
                      context: context,
                      dbType: CategoryType.expense,
                      type: "Add Expense",
                      typeof: Creating.adding);
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ));
  }
}
