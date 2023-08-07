import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home_controller/home_controller.dart';
import '../../../core/constant/color.dart';

class AddDateBar extends GetView<HomeController> {
  const AddDateBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: DatePicker(
        DateTime.now(),
        height: 130,
        width: 70,
        locale: 'ar',
        selectedTextColor: Colors.white,
        selectionColor: AppColor.primaryClr,
        initialSelectedDate: DateTime.now(),
        monthTextStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        dateTextStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        dayTextStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        onDateChange: (newDate) {
          controller.updateSelectedDate(newDate);
          print(controller.selectedDate);
        },
      ),
    );
  }
}
