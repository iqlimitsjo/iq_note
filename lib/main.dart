import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'binding/initial_binding.dart';
import 'core/constant/color.dart';
import 'core/constant/theme.dart';
import 'core/localization/change_local.dart';
import 'core/localization/translation.dart';
import 'core/services/services.dart';
import 'routes.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  AwesomeNotifications().createNotification(
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
        backgroundColor: AppColor.pinkClr),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalController localController = Get.put(LocalController());
    return GetMaterialApp(
      translations: MyTranslation(),
      locale: const Locale('ar'),
      debugShowCheckedModeBanner: false,
      title: 'IQ Note',
      theme: themeLight,
      darkTheme: themeDark,
      themeMode: localController.theme,
      initialBinding: InitBindings(),
      getPages: routes,
    );
  }
}
