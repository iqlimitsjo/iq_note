import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/strings.dart';
import '../services/services.dart';

class LocalController extends GetxController {
  Locale? initLanguages;
  MyServices myServices = Get.find();

  switchTheme() {
    Get.changeThemeMode(getIsDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveTheme(!getIsDarkMode());
  }

  bool getIsDarkMode() {
    return myServices.sharedPref.getBool(AppStrings.isDark) ?? false;
  }

  saveTheme(bool value) {
    myServices.sharedPref.setBool(AppStrings.isDark, value);
  }

  ThemeMode get theme => getIsDarkMode() ? ThemeMode.dark : ThemeMode.light;
}
