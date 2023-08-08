import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:share_plus/share_plus.dart';

import '../../../controller/home_controller/home_controller.dart';
import '../../../data/model/task_model.dart';

class TileButtonBottom extends GetView<HomeController> {
  final TaskModel task;

  const TileButtonBottom(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () => controller.goToEditTask(task),
            tooltip: "تعديل",
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {},
            tooltip: "إرسال إشعار",
            icon: const Icon(
              Icons.notification_add_sharp,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () => controller.deleteTask(task.id!),
            tooltip: "حذف",
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {
              Share.share(
                ' ${task.taskTitle!}\n الملاحظة : ${task.taskBody}',
                subject: "مشاركة ملاحظة",
              );
            },
            tooltip: "مشاركة",
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            )),
      ],
    );
  }
}
