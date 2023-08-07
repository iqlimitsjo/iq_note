import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/add_task_controller/add_task_controller.dart';
import '../../../core/constant/color.dart';

class RecordSection extends StatelessWidget {
  const RecordSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTaskController>(builder: (controller) {
      return Column(
        children: [
          ElevatedButton(
            onPressed: controller.playerState == PlayerState.playing
                ? () {}
                : controller.isRecording
                    ? controller.stopRecording
                    : controller.startRecord,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(10),
              backgroundColor:
                  controller.isRecording ? Colors.red : Colors.green,
            ),
            child: controller.isRecording
                ? const Icon(Icons.stop_circle_outlined)
                : const Icon(Icons.mic),
          ),
          const SizedBox(width: 10),
          if (controller.audioPath != "")
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 10),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: controller.deleteRecord,
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                          backgroundColor: Colors.red),
                      child: const Icon(Icons.delete),
                    ),
                    ElevatedButton(
                      onPressed: controller.playerState == PlayerState.playing
                          ? controller.pausePlayRecording
                          : controller.playRecording,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                        backgroundColor: Colors.deepOrange,
                      ),
                      child: controller.playerState == PlayerState.playing
                          ? const Icon(Icons.pause_outlined)
                          : controller.playerState == PlayerState.completed
                              ? const Icon(Icons.play_arrow)
                              : const Icon(Icons.play_arrow),
                    ),
                    if (controller.playerState == PlayerState.playing ||
                        controller.playerState == PlayerState.paused)
                      ElevatedButton(
                          onPressed: controller.stopPlayRecording,
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(10),
                              backgroundColor: AppColor.black),
                          child: const Icon(Icons.stop)),
                  ],
                ),
                Text(controller.currentDuration.toString().split(".").first),
              ],
            ),
        ],
      );
    });
  }
}
