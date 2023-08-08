import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/model/task_model.dart';

class EditTaskController extends GetxController {
  TaskModel? task;
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  @override
  void onInit() {
    task = Get.arguments['task'];
    title.text = task!.taskTitle!;
    body.text = task!.taskBody!;

    super.onInit();
  }
}
