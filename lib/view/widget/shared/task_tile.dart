import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../controller/home_controller/home_controller.dart';
import '../../../core/constant/strings.dart';
import '../../../data/model/task_model.dart';
import '../../../data/source/static/static_color_list.dart';
import '../../../data/source/static/static_priority_list.dart';
import '../../../data/source/static/static_repeat_list.dart';

class CustomTaskTile extends GetView<HomeController> {
  final TaskModel task;

  const CustomTaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          // dismissible: DismissiblePane(
          //   onDismissed: () => controller.deleteTask(task.id!),
          // ),
          motion: const ScrollMotion(),
          children: [
            const SizedBox(width: 5),
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                Share.share(
                  ' ${task.taskTitle!}\n${task.taskBody} : الملاحظة',
                  subject: task.taskBody,
                );
              },
              backgroundColor: const Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.share,
              label: AppStrings.share,
              spacing: 10,
            ),
            const SizedBox(width: 5),
            SlidableAction(
              autoClose: true,
              onPressed: (context) => controller.deleteTask(task.id!),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppStrings.delete,
              borderRadius: BorderRadius.circular(15),
              spacing: 10,
            ),
          ],
        ),
        startActionPane: ActionPane(
          // dismissible: DismissiblePane(
          //   onDismissed: () => controller.deleteTask(task.id!),
          // ),
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                Share.share(
                  ' ${task.taskTitle!}\n الملاحظة : ${task.taskBody}',
                  subject: "مشاركة ملاحظة",
                );
              },
              backgroundColor: const Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.share,
              label: AppStrings.share,
              spacing: 10,
            ),
            const SizedBox(width: 5),
            SlidableAction(
              autoClose: true,
              onPressed: (context) => controller.deleteTask(task.id!),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppStrings.delete,
              borderRadius: BorderRadius.circular(15),
              spacing: 10,
            ),
            const SizedBox(width: 5),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: colorsList[int.parse(task.color!)].color,
          ),
          child: Row(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.taskTitle!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${task.taskStartTime}  إلى  ${task.taskEndTime}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[100],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      task.taskBody!,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[100],
                      ),
                    ),
                  ],
                ),
              )),
              Column(
                children: [
                  Text(repeatList[int.parse(task.taskRepeat!)].title),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          priorityList[int.parse(task.taskPriority!)].title,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        height: 60,
                        width: 0.5,
                        color: Colors.grey[200]!.withOpacity(0.7),
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          task.taskIsCompleted == "0" ? 'Todo' : 'Completed',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
