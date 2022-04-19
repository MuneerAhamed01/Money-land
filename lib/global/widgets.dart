import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FadeRoute1 extends PageRouteBuilder {
  final Widget page;

  FadeRoute1(this.page)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: page,
          ),
        );
}

class FadeRoute2 extends PageRouteBuilder {
  final Widget page;

  FadeRoute2(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: Duration(milliseconds: 1000),
          reverseTransitionDuration: Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return FadeTransition(
              opacity: animation,
              child: page,
            );
          },
        );
}

class NotificationApi {
  static final _notificaion = FlutterLocalNotificationsPlugin();

  static notificationDetails() async {
    return const NotificationDetails(
        iOS: IOSNotificationDetails(),
        android: AndroidNotificationDetails(
          "CHANNEL_ID",
          "CHANNEL_NAME",
          channelDescription: "CHANNEL_DESCRIPSION",
          importance: Importance.max,
          priority: Priority.max,
        ));
  }

  static Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return _notificaion.show(id, title, body, await notificationDetails(),
        payload: payload);
  }
}
