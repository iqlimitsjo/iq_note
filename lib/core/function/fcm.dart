import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color.dart';

String? localTimeZone;

String? utcTimeZone;

timeZoneConfig() async {
  localTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  utcTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
}

initAwesomeNotifications() {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: 'reminders',
        channelKey: 'instant_notification',
        channelName: 'Basic Instant Notification',
        channelDescription:
            'Notification channel that can trigger notification instantly.',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
      ),
      NotificationChannel(
        channelGroupKey: 'reminders',
        channelKey: 'scheduled_notification',
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

createScheduleNotification(
    [int? id, DateTime? scheduleTime, String? title, String? body]) async {
  return await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 9,
        channelKey: 'scheduled_notification',
        title: "title",
        body: "body",
        wakeUpScreen: true,
        fullScreenIntent: true,
        category: NotificationCategory.Reminder,
        payload: {'uuid': 'uuid-test'},
        autoDismissible: false,
      ),
      schedule: NotificationInterval(
        interval: 60,
        repeats: false,
      ));
}

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

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//
// scheduledNotification(int hours, int minutes, TaskModel task) async {
//   await flutterLocalNotificationsPlugin.zonedSchedule(
//     2,
//     task.taskTitle!,
//     task.taskBody!,
//     //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 50)),
//     nextInstanceOfTenAM(hours, minutes, int.parse(task.taskRemind!),
//         task.taskRepeat!, task.taskDate!),
//       const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'your channel id',
//         'your channel name',
//         channelDescription: 'your channel description',
//       ),
//     ),
//
//     uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//     matchDateTimeComponents: DateTimeComponents.time,
//     payload: '${task.taskTitle}|${task.taskBody}|${task.taskStartTime}|',
//   );
// }
//
// tz.TZDateTime nextInstanceOfTenAM(
//     int hour, int minutes, int remind, String repeat, String date) {
//   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//   var formattedDate = DateFormat.yMd().parse(date);
//   final tz.TZDateTime fd = tz.TZDateTime.from(formattedDate, tz.local);
//   tz.TZDateTime scheduledDate = tz.TZDateTime(
//     tz.local,
//     fd.year,
//     fd.month,
//     fd.day,
//     hour,
//     minutes,
//   );
//
//   scheduledDate = afterRemind(remind, scheduledDate);
//   // check if the time is go
//   if (scheduledDate.isBefore(now)) {
//     // set repeat for notification
//     if (repeat == 'Daily') {
//       //add a 1 day to selected date
//       scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
//           (formattedDate.day) + 1, hour, minutes);
//     }
//     // add 7 day to selected date to make repeat every weekly
//     if (repeat == 'Weekly') {
//       scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
//           (formattedDate.day) + 7, hour, minutes);
//     }
//     // add 1 month to selected date to make repeat every month
//     if (repeat == 'Monthly') {
//       scheduledDate = tz.TZDateTime(tz.local, now.year,
//           (formattedDate.month) + 1, formattedDate.day, hour, minutes);
//     }
//     scheduledDate = afterRemind(remind, scheduledDate);
//   }
//
//   return scheduledDate;
// }
//
// // function to return time of alert subtract the time which user chose
// tz.TZDateTime afterRemind(int remind, tz.TZDateTime scheduledDate) {
//   if (remind == 5) {
//     scheduledDate = scheduledDate.subtract(const Duration(minutes: 5));
//   }
//   if (remind == 10) {
//     scheduledDate = scheduledDate.subtract(const Duration(minutes: 10));
//   }
//   if (remind == 15) {
//     scheduledDate = scheduledDate.subtract(const Duration(minutes: 15));
//   }
//   if (remind == 20) {
//     scheduledDate = scheduledDate.subtract(const Duration(minutes: 20));
//   }
//   return scheduledDate;
// }
//
// Future<void> configureLocalTimeZone() async {
//   tz.initializeTimeZones();
//   final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
//   tz.setLocalLocation(tz.getLocation(timeZoneName));
// }
//
// cancelNotification(TaskModel task) async {
//   await flutterLocalNotificationsPlugin.cancel(1);
// }
//
// cancelAllNotification() async {
//   await flutterLocalNotificationsPlugin.cancelAll();
// }
//
// // for older ios platform called this function
// void onDidReceiveLocalNotification(
//   int id,
//   String? title,
//   String? body,
//   String? payload,
// ) async {
//   // display a dialog with the notification details, tap ok to go to another page
//   Get.dialog(Text(body!));
// }
