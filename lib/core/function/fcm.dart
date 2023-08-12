import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color.dart';

String? localTimeZone;

String? utcTimeZone;

// timeZoneConfig() async {
//   localTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
//   utcTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
// }

// initAwesomeNotifications() {
//   AwesomeNotifications().initialize(
//     null,
//     [
//       NotificationChannel(
//         channelGroupKey: 'reminders',
//         channelKey: 'instant_notification',
//         channelName: 'Basic Instant Notification',
//         channelDescription:
//             'Notification channel that can trigger notification instantly.',
//         defaultColor: const Color(0xFF9D50DD),
//         ledColor: Colors.white,
//       ),
//       NotificationChannel(
//         channelGroupKey: 'reminders',
//         channelKey: 'scheduled_notification',
//         channelName: 'Scheduled Notification',
//         channelDescription:
//             'Notification channel that can trigger notification based on predefined time.',
//         defaultColor: const Color(0xFF9D50DD),
//         ledColor: Colors.white,
//       ),
//     ],
//   );
// }

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
          channelKey: "scheduled_notification",
          color: Colors.white,
          title: message.notification!.title!,
          body: message.notification!.body!,
          category: NotificationCategory.Reminder,
          wakeUpScreen: true,
          locked: true,
          fullScreenIntent: true,
          autoDismissible: false,
          backgroundColor: AppColor.primaryClr),
    );

    // getOrderNumber(message.data);

    // controller.getOrders();
  });

  // AwesomeNotifications().actionStream.listen((event) {
  //   if (event.buttonKeyPressed == "ACCEPT") {
  //     // controller.changeOrderState(controller.orderId!, "1");
  //   } else if (event.buttonKeyPressed == "REJECT") {
  //     print("reject");
  //   }
  // });
}

refreshPageNotification(data) {
  if (data['pagename'] == 'orders' && Get.currentRoute == '/orders') {}
}

// createScheduleNotification(
//     [int? id, DateTime? scheduleTime, String? title, String? body]) async {
//   return await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: 9,
//         channelKey: 'scheduled_notification',
//         title: "title",
//         body: "body",
//         wakeUpScreen: true,
//         fullScreenIntent: true,
//         category: NotificationCategory.Reminder,
//         payload: {'uuid': 'uuid-test'},
//         autoDismissible: false,
//       ),
//       schedule: NotificationInterval(
//         interval: 60,
//         repeats: false,
//       ));
// }

requestNotificationPermissions() async {
  // NotificationSettings setting =
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
