import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_land/database/moneyland_model_class.dart';
import 'package:money_land/global/styles.dart';
import 'package:money_land/logic/notifcation/notificaton_cubit.dart';
import 'package:money_land/main.dart';
import 'package:money_land/themes/colors/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../homepage/assest/functions.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSwitchedFT = false;
  @override
  void initState() {
    super.initState();
    getSwitchValues();
  }

  getSwitchValues() async {
    isSwitchedFT = await getSwitchState();
    setState(() {});
  }

  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("switchState", value);

    return prefs.setBool("switchState", value);
  }

  Future<bool> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSwitchedFT = prefs.getBool("switchState") ?? false;

    return isSwitchedFT;
  }

  double? totalExp;
  double? totalIncome;

  @override
  Widget build(BuildContext context) {
    if (isSwitchedFT == true) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 0,
          channelKey: "Channel_key",
          title: "Balance :💰 ${totalIncome! - totalExp!}",
          body: 'Income : 🟢 $totalIncome  Expesne : 🔴 $totalExp',
          fullScreenIntent: true,
          displayOnBackground: true,
          notificationLayout: NotificationLayout.Inbox,
        ),
      );
    }
    final transaction =
        Hive.box<AddTransaction>(db_transaction).values.toList();
    totalExp = totalTransaction(transaction, CategoryType.expense);
    totalIncome = totalTransaction(transaction, CategoryType.income);
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
          return index == 0
              ? BlocBuilder<NotificatonCubit, NotificatonState>(
                  builder: (context, state) {
                    return SwitchListTile(
                      value: state.value,
                      activeTrackColor: themeColor,
                      activeColor: lightColor,
                      onChanged: (value) async {
                        context.read<NotificatonCubit>().changeOf(value);
                        saveSwitchState(value);
                        gotoSettings(0,
                            value: value,
                            expense: state.totalExp,
                            income: state.totalInc);
                      },
                      title: Row(
                        children: [
                          Icon(settings[index].icon),
                          SizedBox(
                            width: 30.w,
                          ),
                          Text(
                            "${settings[index].title}",
                            style: TextStyle(fontSize: 20.sp),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : ListTile(
                  textColor: realBlack,
                  iconColor: realBlack,
                  onTap: () {
                    gotoSettings(index, value: isSwitchedFT);
                  },
                  leading: Icon(settings[index].icon),
                  title: Text(
                    "${settings[index].title}",
                    style: TextStyle(fontSize: 20.sp),
                  ),
                );
        },
        itemCount: 6,
      ),
    );
  }

  gotoSettings(int index,
      {bool? value, double? expense, double? income}) async {
    if (index == 0) {
      if (value == true) {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 0,
            channelKey: "Channel_key",
            title: "Balance : ${income! - expense!}",
            body: "Income : $income  Expesne : $expense",
            fullScreenIntent: true,
            displayOnBackground: true,
            notificationLayout: NotificationLayout.Inbox,
          ),
        );
      } else {
        AwesomeNotifications().cancelAll();
      }
    } else if (index == 1) {
    } else if (index == 2) {
    } else if (index == 3) {
      final email = Uri(path: "muneerahamed6455@gmail.com");

      await launchUrl(email);
    } else if (index == 4) {
      final url = Uri(path: "https://muneerahamed01.github.io/MuneerAhamed/");

      await launchUrl(url);
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

  onNotificationclicked(String payload) {}
}

class AppSettings {
  IconData? icon;
  String? title;
  AppSettings({this.icon, this.title});
}
