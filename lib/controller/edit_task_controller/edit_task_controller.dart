import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/status_request.dart';
import '../../core/function/handling_data_controller.dart';
import '../../core/function/show_snackbar.dart';
import '../../core/services/services.dart';
import '../../data/model/task_model.dart';
import '../../data/source/remote/task_remote/task_remote.dart';
import '../home_controller/home_controller.dart';

class EditTaskController extends GetxController {
  TaskModel? task;
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  StatusRequest statusRequest = StatusRequest.none;
  TaskData taskData = TaskData(Get.find());
  HomeController homeController = Get.find();
  MyServices myServices = Get.find();
  bool isImageDeleted = false;
  bool isVoiceDeleted = false;

  updateTask(Map<String, dynamic> data) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await taskData.updateTask('limits', task!.id!, data);
    statusRequest = handlingFirebaseData(response);
    if (statusRequest == StatusRequest.success) {
      homeController.getTask();
      update();
    }
    update();
  }

  deleteAttachments(String collectionName) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await taskData.deleteFile(collectionName, task!.id!);
    statusRequest = handlingFirebaseData(response);
    if (statusRequest == StatusRequest.success) {
      collectionName == "Voice" ? isVoiceDeleted = true : isImageDeleted = true;
      update();
      collectionName == "Voice"
          ? updateTask({
              'attachments': {'audio_url': null}
            })
          : updateTask({
              'attachments': {'image_url': null}
            });
      showSnackBar("تم بنجاح", "تم الحذف بنجاح", Icons.edit);
    }
    update();
  }

  @override
  void onInit() {
    task = Get.arguments['task'];
    title.text = task!.taskTitle!;
    body.text = task!.taskBody!;

    super.onInit();
  }
}
