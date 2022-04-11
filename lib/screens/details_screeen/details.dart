import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_land/database/moneyland_model_class.dart';

import 'package:money_land/global/styles.dart';
import 'package:money_land/screens/details_screeen/widgets/widgets.dart';
import 'package:money_land/screens/homepage/assest/styles.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:money_land/themes/mediaquery/mediaquery.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    Key? key,
    required this.name,
  }) : super(key: key);
  final Map? name;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat(' EEE d MMM').format(name!["date"]);
    final Categories data = name!["category"];

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(
                Icons.edit_note,
                color: Colors.black,
              ),
              onPressed: () {
                navigateToEdit(context);
              },
            )
          ],
          centerTitle: true,
          foregroundColor: Colors.black,
          toolbarHeight: 70,
          backgroundColor: lightColor,
          shadowColor: Colors.transparent,
          title: Text(
            'Details',
            style: titleText(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: Container(
            decoration: roundedConrner(lightColor),
            height: double.infinity,
            width: double.infinity,
            // color: lightColor,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name!["purpose"],
                        style: boldText(30),
                      ),
                      Text(
                        formattedDate,
                        style: const TextStyle(fontSize: 19),
                      )
                    ],
                  ),
                  SizedBox(
                    height: mediaQuery(context, 0.06),
                  ),
                  textShow("Amount :", boldText(35)),
                  SizedBox(
                    height: mediaQuery(context, 0.02),
                  ),
                  textShow(
                    '₹ ${name!["amount"]}',
                    const TextStyle(fontSize: 35),
                  ),
                  SizedBox(height: mediaQuery(context, 0.06)),
                  textShow("Category :", boldText(35)),
                  SizedBox(height: mediaQuery(context, 0.02)),
                  textShow(data.category!, const TextStyle(fontSize: 25)),
                  SizedBox(height: mediaQuery(context, 0.06)),
                  textShow("Notes :", boldText(35)),
                  SizedBox(height: mediaQuery(context, 0.02)),
                  textShow(name!["notes"], const TextStyle(fontSize: 25)),
                  SizedBox(height: mediaQuery(context, 0.06)),
                  textShow("Type :", boldText(35)),
                  SizedBox(height: mediaQuery(context, 0.02)),
                  textShow(
                      name!["type"] == CategoryType.income
                          ? "Income"
                          : "Expense",
                      const TextStyle(fontSize: 25))
                ],
              ),
            ),
          ),
        ));
  }

  navigateToEdit(BuildContext context) {
    Navigator.pushNamed(context, "/editscreen", arguments: name);
  }
}
