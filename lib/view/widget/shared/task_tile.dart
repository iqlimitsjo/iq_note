import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

import '../../../controller/home_controller/home_controller.dart';
import '../../../data/model/task_model.dart';
import '../../../data/source/static/static_color_list.dart';
import '../../../data/source/static/static_department_list.dart';
import '../../../data/source/static/static_priority_list.dart';
import '../../../data/source/static/static_repeat_list.dart';
import '../../../data/source/static/ststic_remind_list.dart';
import '../../../data/source/static/user_data.dart';
import '../task_tile/tile_bottom_button.dart';

class CustomTaskTile extends GetView<HomeController> {
  final TaskModel task;

  const CustomTaskTile({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1.2, color: Colors.transparent),
          borderRadius: BorderRadius.circular(15),
        ),
        collapsedShape: RoundedRectangleBorder(
          side: const BorderSide(width: 1.2, color: Colors.transparent),
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: colorsList[int.parse(task.color!)].color,
        collapsedBackgroundColor: colorsList[int.parse(task.color!)].color,
        title: Text(
          task.taskTitle!,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 21),
        ),
        childrenPadding: const EdgeInsets.all(15),
        textColor: Colors.white,
        subtitle: Text(
          task.taskDate!,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: Column(
          children: [
            Text(priorityList[int.parse(task.taskPriority!)].title),
            Text(
              departmentList[int.parse(task.department!)].title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        leading: Column(
          children: [
            Text(task.taskIsCompleted == "0" ? 'غير مكتمل' : 'مكتمل'),
            if (task.audioUrl != null || task.imageUrl != null)
              const Icon(Icons.attach_file)
          ],
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                " تذكير: ${remindList[int.parse(task.taskRepeat!)].title}",
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                " تكرار: ${repeatList[int.parse(task.taskRepeat!)].title}",
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
          const Divider(color: Colors.white),
          Text(
            task.taskBody!,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 10),
          if (task.imageUrl != null || task.audioUrl != null)
            GetBuilder<HomeController>(builder: (controller) {
              return Column(
                children: [
                  const Divider(color: Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (task.imageUrl != null)
                        SizedBox(
                          height: 100,
                          child: InstaImageViewer(
                              child: CachedNetworkImage(
                            imageUrl: task.imageUrl!,
                          )),
                        ),
                      if (task.audioUrl != null)
                        SizedBox(
                          height: 100,
                          child: ElevatedButton(
                            onPressed: controller.playerState ==
                                    PlayerState.playing
                                ? controller.pausePlayRecording
                                : () =>
                                    controller.playRecording(task.audioUrl!),
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(10),
                              backgroundColor: Colors.teal,
                            ),
                            child: controller.playerState == PlayerState.playing
                                ? const Icon(Icons.pause_outlined, size: 50)
                                : controller.playerState ==
                                        PlayerState.completed
                                    ? const Icon(Icons.play_arrow, size: 50)
                                    : const Icon(Icons.play_arrow, size: 50),
                          ),
                        ),
                    ],
                  ),
                ],
              );
            }),
          const Divider(color: Colors.white),
          if (userDataList[0].userLevel == "1" ||
              userDataList[0].userLevel == "2")
            TileButtonBottom(task),
        ],
      ),
    );
  }
}
