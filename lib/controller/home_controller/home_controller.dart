import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../core/class/status_request.dart';
import '../../core/constant/routes.dart';
import '../../core/constant/strings.dart';
import '../../core/function/handling_data_controller.dart';
import '../../core/function/show_snackbar.dart';
import '../../core/services/services.dart';
import '../../data/model/task_model.dart';
import '../../data/source/remote/task_remote/task_remote.dart';

class HomeController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  DateTime selectedDate = DateTime.now();
  TaskData taskData = TaskData(Get.find());
  List<TaskModel> data = [];

  goToSelectedFilter() async {
    DateTime? dataPicker = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2035),
      helpText: "إختر التاريخ",
      confirmText: AppStrings.ok,
      cancelText: AppStrings.cancel,
    );
    if (dataPicker != null) {
      Get.toNamed(AppRoutes.filteredTask, arguments: {
        'selectedDate': DateFormat.yMd().format(dataPicker).toString(),
        "task": data.where((element) =>
            DateFormat.yMd().parse(element.taskDate!) == dataPicker)
      });
    }
  }

  getTask() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await taskData.getTask("limits");
    statusRequest = handlingFirebaseData(response.$2);
    if (statusRequest == StatusRequest.success &&
        response.$2.message == "success") {
      for (var element in response.$1) {
        data.add(TaskModel.fromFirestore(element));
      }
      statusRequest = StatusRequest.success;
    }

    print(response.$2.message);

    update();
  }

  deleteTask(String id) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await taskData.deleteTask('limits', id);
    statusRequest = handlingFirebaseData(response);
    if (statusRequest == StatusRequest.success) {
      await showSnackBar(
          "تم بنجاح", "تم حذف الملاحظة بنجاح", Icons.delete_forever);

      getTask();
      update();
    }
    update();
  }

  updateTask(String id, String value) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await taskData.updateTask('limits', id, {
      'isCompleted': value,
    });
    statusRequest = handlingFirebaseData(response);
    if (statusRequest == StatusRequest.success) {
      await showSnackBar("تم بنجاح", "تم تعديل الملاحظة بنجاح", Icons.edit);

      getTask();
      update();
    }
    update();
  }

  updateSelectedDate(DateTime? dateTime) {
    selectedDate = dateTime ?? DateTime.now();
    update();
  }

  @override
  void onInit() {
    initializeDateFormatting();
    getTask();
    super.onInit();
  }
}
