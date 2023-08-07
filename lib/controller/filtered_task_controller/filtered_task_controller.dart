import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/status_request.dart';
import '../../core/function/handling_data_controller.dart';
import '../../core/function/show_snackbar.dart';
import '../../data/model/task_model.dart';
import '../../data/source/remote/task_remote/task_remote.dart';

class FilteredTaskController extends GetxController {
  List<TaskModel> data = [];
  String? selectedDate;
  TaskData taskData = TaskData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  deleteTask(String id) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await taskData.deleteTask('limits', id);
    statusRequest = handlingFirebaseData(response);
    if (statusRequest == StatusRequest.success) {
      await showSnackBar(
          "تم بنجاح", "تم حذف الملاحظة بنجاح", Icons.delete_forever);

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

      update();
    }
    update();
  }

  @override
  void onInit() {
    selectedDate = Get.arguments['selectedDate'];
    data.addAll(Get.arguments['task']);
    super.onInit();
  }
}
