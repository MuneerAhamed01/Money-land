import 'package:flutter/material.dart';

import '../../../global/styles.dart';
import '../../../themes/mediaquery/mediaquery.dart';

class Income extends StatelessWidget {
  const Income({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List income = ["Stocks", "Salary", "Buisness"];
    return Container(
      color: Colors.white,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              income[index],
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
