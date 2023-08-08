import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

import '../../../../controller/edit_task_controller/edit_task_controller.dart';
import '../../../../controller/home_controller/home_controller.dart';
import '../../../../core/constant/strings.dart';
import '../../../widget/shared/app_bar.dart';
import '../../../widget/shared/app_drawer.dart';
import '../../../widget/shared/button.dart';
import '../../../widget/shared/no_border_input.dart';

class EditTask extends StatelessWidget {
  const EditTask({super.key});

  @override
  Widget build(BuildContext context) {
    EditTaskController controller = Get.put(EditTaskController());
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: customAppBar(title: controller.task!.taskTitle!, isHome: false),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ExpansionTile(
                initiallyExpanded: true,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                collapsedShape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                title: NoBorderInputField(
                  isReadOnly: false,
                  isEnabled: true,
                  textController: controller.title,
                ),
                childrenPadding: const EdgeInsets.all(15),
                children: [
                  const Divider(),
                  NoBorderInputField(
                    isReadOnly: false,
                    isEnabled: true,
                    textController: controller.body,
                  ),
                  const SizedBox(height: 10),
                  if (controller.task!.imageUrl != null ||
                      controller.task!.audioUrl != null)
                    GetBuilder<HomeController>(builder: (logic) {
                      return Column(
                        children: [
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (controller.task!.imageUrl != null)
                                SizedBox(
                                  height: 100,
                                  child: InstaImageViewer(
                                    child: Image(
                                      image: Image.network(
                                              controller.task!.imageUrl!)
                                          .image,
                                    ),
                                  ),
                                ),
                              if (controller.task!.audioUrl != null)
                                SizedBox(
                                  height: 100,
                                  child: ElevatedButton(
                                    onPressed:
                                        logic.playerState == PlayerState.playing
                                            ? logic.pausePlayRecording
                                            : () => logic.playRecording(
                                                controller.task!.audioUrl!),
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(10),
                                      backgroundColor: Colors.teal,
                                    ),
                                    child:
                                        logic.playerState == PlayerState.playing
                                            ? const Icon(Icons.pause_outlined,
                                                size: 50)
                                            : logic.playerState ==
                                                    PlayerState.completed
                                                ? const Icon(Icons.play_arrow,
                                                    size: 50)
                                                : const Icon(Icons.play_arrow,
                                                    size: 50),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      );
                    }),
                ],
              ),
            ),
            CustomButton(
              onPressed: () {},
              title: AppStrings.save,
              maxWidth: false,
            )
          ],
        ),
      ),
    );
  }
}
