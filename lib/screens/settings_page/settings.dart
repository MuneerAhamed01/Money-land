import 'package:flutter/material.dart';
import 'package:money_land/global/styles.dart';
import 'package:money_land/main.dart';
import 'package:money_land/themes/colors/colors.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    List<AppSettings> settings = [
      AppSettings(icon: Icons.notifications, title: 'Notification'),
      AppSettings(icon: Icons.share, title: 'Share'),
      AppSettings(icon: Icons.reviews, title: 'Write a review'),
      AppSettings(icon: Icons.feedback, title: 'FeedBack'),
      AppSettings(icon: Icons.privacy_tip, title: 'Privacy and Policy'),
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
              leading: IconButton(
                icon: Icon(settings[index].icon),
                onPressed: () {
                  if (index == 6) {
                    print("object");
                    db_Categories.clearHive();
                  }
                },
              ),
              title: Text(
                "${settings[index].title}",
                style: const TextStyle(fontSize: 20),
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
        itemCount: 7,
      ),
    );
  }
}

class AppSettings {
  IconData? icon;
  String? title;
  AppSettings({this.icon, this.title});
}
