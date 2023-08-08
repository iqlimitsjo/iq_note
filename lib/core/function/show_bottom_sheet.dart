import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/task_model.dart';
import '../constant/color.dart';

showCustomBottomSheet({
  required TaskModel task,
  void Function()? onUpdateTap,
  void Function()? onDeleteTap,
}) {
  Get.bottomSheet(SingleChildScrollView(
    child: Container(
      margin: const EdgeInsets.only(top: 4),
      color: Get.isDarkMode ? AppColor.darkGreyClr : Colors.white,
      height: 260,
      width: double.infinity,
      child: Column(
        children: [
          Flexible(
            child: Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
              ),
            ),
          ),
          const SizedBox(height: 20),
          buildBottomSheet(
            label: task.taskIsCompleted == "0"
                ? "إتمام الملاحظة"
                : "جعل الملاحظة غير مكتملة",
            onTap: onUpdateTap,
            clr: Colors.green,
          ),
          buildBottomSheet(
            label: "تأجيل الملاحظة",
            onTap: onDeleteTap,
            clr: Colors.redAccent,
          ),
          Divider(
            color: Get.isDarkMode ? Colors.grey : AppColor.darkGreyClr,
          ),
          buildBottomSheet(
              label: "إلغاء",
              onTap: () {
                Get.back();
              },
              clr: AppColor.primaryClr),
          const SizedBox(height: 20),
        ],
      ),
    ),
  ));
}

buildBottomSheet(
    {required String label,
    required void Function()? onTap,
    required Color clr,
    bool isClose = false}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: isClose
              ? Get.isDarkMode
                  ? Colors.grey[600]!
                  : Colors.grey[300]!
              : clr,
        ),
        borderRadius: BorderRadius.circular(20),
        color: isClose ? Colors.transparent : clr,
      ),
      child: Center(
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    ),
  );
}
