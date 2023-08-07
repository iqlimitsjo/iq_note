import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/strings.dart';
import '../../../core/localization/change_local.dart';

LocalController localController = Get.find();

AppBar customAppBar({
  required String title,
  required bool? isHome,
  void Function()? onPressed,
  void Function()? onSelectDatePressed,
}) {
  return AppBar(
    title: Text(title, style: const TextStyle(fontSize: 25)),
    centerTitle: true,

    actions: [
      if (isHome == false)
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      if (isHome == true)
        Row(
          children: [
            IconButton(
              tooltip: AppStrings.refresh,
              onPressed: onPressed,
              icon: const Icon(
                Icons.refresh_outlined,
              ),
            ),
            IconButton(
              onPressed: onSelectDatePressed,
              tooltip: AppStrings.selectDate,
              icon: const Icon(
                Icons.calendar_month,
              ),
            ),
          ],
        ),
    ],
    // elevation: 10,
  );
}
