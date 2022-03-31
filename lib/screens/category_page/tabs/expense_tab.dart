import 'package:flutter/material.dart';

import '../../../global/styles.dart';
import '../../../themes/mediaquery/mediaquery.dart';

class Expense extends StatelessWidget {
  const Expense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List expense = ["Loan", "Vehicle", "House"];
    return Container(
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              expense[index],
              style: boldText(20),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.edit),
                SizedBox(
                  width: mediaQueryWidth(context, 0.05),
                ),
                Icon(Icons.delete)
              ],
            ),
          );
        },
        itemCount: 3,
      ),
    );
  }
}
