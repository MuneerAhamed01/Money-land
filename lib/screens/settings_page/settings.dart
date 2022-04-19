import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_land/database/moneyland_model_class.dart';
import 'package:money_land/global/styles.dart';
import 'package:money_land/global/widgets.dart';
import 'package:money_land/main.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool value = false;
  @override
  void initState() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('download');
    var initializationSettingsAndroidOf =
        InitializationSettings(android: initializationSettingsAndroid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    List<AppSettings> settings = [
      AppSettings(icon: Icons.notifications, title: 'Notification'),
      AppSettings(icon: Icons.share, title: 'Share'),
      AppSettings(icon: Icons.reviews, title: 'Write a review'),
      AppSettings(icon: Icons.feedback, title: 'FeedBack'),
      AppSettings(icon: Icons.person, title: 'About us'),
      AppSettings(icon: Icons.reset_tv, title: 'Reset'),
    ];

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: lightColor,
          shadowColor: Colors.transparent,
          title: Text(
            "Settings",
            style: titleText(),
          )),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
              onTap: () {
                gotoSettings(index);
              },
              leading: Icon(settings[index].icon),
              title: Text(
                "${settings[index].title}",
                style: TextStyle(fontSize: 20.sp),
              ),
              trailing: index == 0
                  ? Switch(
                      activeTrackColor: themeColor,
                      activeColor: lightColor,
                      value: value,
                      onChanged: (val) {
                        setState(() {
                          value = val;
                        });
                      })
                  : null);
        },
        itemCount: 6,
      ),
    );
  }

  gotoSettings(int index) async {
    final transaction =
        Hive.box<AddTransaction>(db_transaction).values.toList();
    if (index == 0) {
      NotificationApi.showNotification(
          body: "transaction[0].notes",
          title: "transaction[0].amount.toString()",
          payload: "transaction[0].category!.category");
      setState(() {
        value = !value;
      });
    } else if (index == 1) {
    } else if (index == 2) {
    } else if (index == 3) {
    } else if (index == 4) {
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text(' Are  you sure'),
          content:
              const Text('All the transaction and categories will be deleted'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                db_trans.clearTransactionHive();
                db_Categories.clearHive();

                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  onNotificationclicked(String payload) {
    print(payload);
  }
}

class AppSettings {
  IconData? icon;
  String? title;
  AppSettings({this.icon, this.title});
}
