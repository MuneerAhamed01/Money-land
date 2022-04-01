import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_land/global/styles.dart';
import 'package:money_land/screens/homepage/assest/styles.dart';
import 'package:money_land/screens/homepage/assest/widgets.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat(' EEE d MMM').format(now);

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Home",
          style: titleText(),
        ),
        backgroundColor: lightColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                    height: mediaQuery(context, 0.44),
                    decoration: roundedConrner(lightColor)),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
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
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text(
                "Recent Transaction",
                style: boldText(17),
              ),
            ),
            SizedBox(
              height: mediaQuery(context, 0.02),
            ),
            ListView.separated(
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
                        "EXP",
                        style: boldText(17),
                      ),
                    ),
                    title: Text("Engine Work"),
                    subtitle: Text(formattedDate),
                    trailing: Text(
                      "₹ 500",
                      style: boldText(25),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: 10)
          ],
        ),
      ),
    );
  }
}
