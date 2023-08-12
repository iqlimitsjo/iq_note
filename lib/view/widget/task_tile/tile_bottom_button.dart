import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:share_plus/share_plus.dart';

import '../../../controller/home_controller/home_controller.dart';
import '../../../data/model/task_model.dart';
import '../../../data/source/static/static_department_list.dart';

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
        PopupMenuButton(
          itemBuilder: (context) => <PopupMenuEntry>[
            PopupMenuItem(
              value: "0",
              child: Text(
                  'إلى قسم  ${departmentList[int.parse(task.department!)].title} '),
            ),
            const PopupMenuItem(
              value: "1",
              child: Text('إلى شخص'),
            ),
          ],
          icon: const Icon(
            Icons.notification_add_sharp,
            color: Colors.white,
          ),
          onSelected: (item) {
            if (item == "0") {
              controller.sendTaskNotificationToDepartment(task);
            }
            if (item == "1") {
              controller.goToSendNotificationToPerson(task);
            }
          },
        ),
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
