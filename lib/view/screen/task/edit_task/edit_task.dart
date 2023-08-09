import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

import '../../../../controller/edit_task_controller/edit_task_controller.dart';
import '../../../../controller/home_controller/home_controller.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/constant/strings.dart';
import '../../../../core/function/show_snackbar.dart';
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
        child: GetBuilder<EditTaskController>(builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: ListView(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  if (controller.task!.imageUrl != null &&
                                      controller.isImageDeleted == false)
                                    Stack(
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          child: InstaImageViewer(
                                              child: CachedNetworkImage(
                                            imageUrl:
                                                controller.task!.imageUrl!,
                                          )),
                                        ),
                                        Positioned(
                                          child: InkWell(
                                            onTap: () => controller
                                                .deleteAttachments("Images"),
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Colors.red),
                                              child: const Center(
                                                  child: Text(
                                                "X",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (controller.task!.audioUrl != null &&
                                      controller.isVoiceDeleted == false)
                                    Stack(
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          child: ElevatedButton(
                                            onPressed: logic.playerState ==
                                                    PlayerState.playing
                                                ? logic.pausePlayRecording
                                                : () => logic.playRecording(
                                                    controller.task!.audioUrl!),
                                            style: ElevatedButton.styleFrom(
                                              shape: const CircleBorder(),
                                              padding: const EdgeInsets.all(10),
                                              backgroundColor: Colors.teal,
                                            ),
                                            child: logic.playerState ==
                                                    PlayerState.playing
                                                ? const Icon(
                                                    Icons.pause_outlined,
                                                    size: 50)
                                                : logic.playerState ==
                                                        PlayerState.completed
                                                    ? const Icon(
                                                        Icons.play_arrow,
                                                        size: 50)
                                                    : const Icon(
                                                        Icons.play_arrow,
                                                        size: 50),
                                          ),
                                        ),
                                        Positioned(
                                          child: InkWell(
                                            onTap: () => controller
                                                .deleteAttachments("Voice"),
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Colors.red),
                                              child: const Center(
                                                  child: Text(
                                                "X",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                          ),
                                        ),
                                      ],
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
                  onPressed: () async {
                    await controller.updateTask({
                      'title': controller.title.text,
                      'body': controller.body.text,
                    });
                    Get.offNamed(AppRoutes.home);
                    showSnackBar(
                        "تم بنجاح", "تم تعديل الملاحظة بنجاح", Icons.edit);
                  },
                  title: AppStrings.save,
                  maxWidth: false,
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
