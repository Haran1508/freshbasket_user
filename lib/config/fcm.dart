import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Fcm {
  static Fcm fcm = Fcm();
  static bool alreadyInited = false;

  static getInstance() {
    if (fcm == null) {
      fcm = Fcm();
    }
    return fcm;
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final List<NotificationMessages> messages = [];
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<String?> chatNotification() async {
    var fbToken = await _firebaseMessaging.getToken();
    var android =
        new AndroidInitializationSettings('@mipmap/ic_launcher_foreground');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android: android, iOS: ios);
    _firebaseMessaging.requestPermission();
    flutterLocalNotificationsPlugin.initialize(platform);

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      print("here1..");
      if (message != null) {
        try {
          showNotification(message).then((onvalue) {
            return;
          });
        } catch (e) {
          print("error:" + e.toString());
        }
      }
    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print("here4..");
      if (message != null) {
        try {
          showNotification(message).then((onvalue) {
            return;
          });
        } catch (e) {
          print("error:" + e.toString());
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("here2..");
      if (message != null) {
        try {
          print(message.data["order"]);
          print(message.data["action_required"]);
          print(message.data);
          print(message.notification!.body);
          print(message.notification!.title);
          showNotification(message).then((onvalue) {
            return;
          });
        } catch (e) {
          print("error:" + e.toString());
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("here3..");
      if (message != null) {
        print(message.data["order"]);
        print(message.data["action_required"]);
        print(message.data);
        print(message.notification!.body);
        print(message.notification!.title);
        try {} catch (e) {
          print("error:" + e.toString());
        }
      }
    });

    return fbToken;
  }

  showNotification(RemoteMessage message) async {
    // print("notification working...." + message.senderId);
    var android = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription');
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    // final  ` notification = message['notification'];
    await flutterLocalNotificationsPlugin.show(
        0, message.notification!.title, message.notification!.body, platform);
  }
}

@immutable
class NotificationMessages {
  final String? title;
  final String? body;

  const NotificationMessages({
    @required this.title,
    @required this.body,
  });
}
