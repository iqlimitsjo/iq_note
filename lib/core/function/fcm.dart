import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../constant/color.dart';

initAwesomeNotifications() {
  AwesomeNotifications().initialize(
    'resource://drawable/appicon',
    [
      NotificationChannel(
        channelGroupKey: 'task_notification',
        channelKey: 'task_notification',
        channelName: 'Basic Instant Notification',
        channelDescription:
            'Notification channel that can trigger notification instantly.',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
      ),
      NotificationChannel(
        channelGroupKey: 'reminders',
        channelKey: 'task_notification',
        channelName: 'Scheduled Notification',
        channelDescription:
            'Notification channel that can trigger notification based on predefined time.',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
      ),
    ],
  );
}

fcmConfig() {
  // FirebaseMessaging.onMessage.listen((message) {
  //   Get.snackbar(
  //     message.notification!.title!.tr,
  //     message.notification!.body!.tr,
  //     icon: const Icon(Icons.notifications_active_outlined),
  //   );
  //   refreshPageNotification(message.data);
  // });

  FirebaseMessaging.onMessage.listen((message) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 123,
          channelKey: "task_notification",
          color: Colors.white,
          title: message.notification!.title!,
          body: message.notification!.body!,
          category: NotificationCategory.Event,
          wakeUpScreen: true,
          locked: true,
          fullScreenIntent: true,
          autoDismissible: true,
          backgroundColor: AppColor.primaryClr),
    );
  });
}

requestNotificationPermissions() async {
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}
