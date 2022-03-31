import 'package:flutter/material.dart';
import 'package:money_land/global/styles.dart';
import 'package:money_land/screens/homepage/assest/styles.dart';
import 'package:money_land/themes/colors/colors.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: const [
            IconButton(
              icon: Icon(
                Icons.edit_note,
                color: Colors.black,
              ),
              onPressed: null,
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
            child: Column(
              children: [],
            ),
          ),
        ));
  }
}
