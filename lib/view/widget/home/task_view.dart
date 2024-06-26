import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home_controller/home_controller.dart';
import '../../../core/class/handling_data_view.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<HomeController>(builder: (controller) {
        return HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: RefreshIndicator(
              color: Colors.green,
              onRefresh: () => controller.getTask(),
              child: ListView(
                children: [
                  // ...List.generate(controller.data.length, (index) {
                  //   var task = controller.data[index];
                  //
                  //   if (task.taskRepeat == repeatList[1].value ||
                  //       task.taskDate ==
                  //           DateFormat.yMd().format(controller.selectedDate) ||
                  //       (task.taskRepeat == repeatList[2].value &&
                  //           controller.selectedDate
                  //                       .difference(DateFormat.yMd()
                  //                           .parse(task.taskDate!))
                  //                       .inDays %
                  //                   7 ==
                  //               0) ||
                  //       (task.taskRepeat == repeatList[3].value &&
                  //           DateFormat.yMd().parse(task.taskDate!).day ==
                  //               controller.selectedDate.day)) {
                  //     var date = DateFormat.jm().parse(task.taskStartTime!);
                  //     var myTime = DateFormat('HH:mm').format(date);
                  //
                  //     controller.notifiHelper.scheduledNotification(
                  //       int.parse(myTime.toString().split(':')[0]),
                  //       int.parse(myTime.toString().split(':')[1]),
                  //       task,
                  //     );
                  //     return AnimationConfiguration.staggeredList(
                  //       duration: const Duration(milliseconds: 500),
                  //       position: index,
                  //       child: SlideAnimation(
                  //         horizontalOffset: 300,
                  //         child: GestureDetector(
                  //           onTap: () {
                  //             showCustomBottomSheet(
                  //               task: task,
                  //               onUpdateTap: () {
                  //                 controller.updateTask(
                  //                     controller.data[index].id!,
                  //                     controller.data[index].taskIsCompleted ==
                  //                             "0"
                  //                         ? "1"
                  //                         : "0");
                  //                 Get.isBottomSheetOpen == true
                  //                     ? Get.back()
                  //                     : Get.back();
                  //               },
                  //               onDeleteTap: () async {
                  //                 DateTime? dataPicker = await showDatePicker(
                  //                   context: context,
                  //                   initialDate: controller.selectedDate,
                  //                   firstDate: DateTime(2022),
                  //                   lastDate: DateTime(2035),
                  //                   helpText: "إختر التاريخ",
                  //                   confirmText: AppStrings.ok,
                  //                   cancelText: AppStrings.cancel,
                  //                 );
                  //                 if (dataPicker != null) {
                  //                   controller.delayTask(
                  //                       controller.data[index].id!,
                  //                       DateFormat.yMd()
                  //                           .format(dataPicker)
                  //                           .toString());
                  //                 }
                  //                 Get.isBottomSheetOpen!
                  //                     ? Get.back()
                  //                     : Get.back();
                  //               },
                  //             );
                  //           },
                  //           child: CustomTaskTile(
                  //             task: task,
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   } else {
                  //     return Container();
                  //   }
                  // })

                  ...List.generate(
                      controller.data.length,
                      (index) => Card(
                            color: Colors.green,
                            surfaceTintColor: Colors.green,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        controller.data[index].taskTitle!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                        ),
                                      )),
                                ),
                                if (controller.data[index].audioUrl != null ||
                                    controller.data[index].imageUrl != null)
                                  const Expanded(
                                      child: Center(
                                    child: Icon(
                                      Icons.attach_file,
                                      color: Colors.white,
                                    ),
                                  )),
                                Expanded(
                                    child: Checkbox(
                                  value:
                                      controller.data[index].taskIsCompleted ==
                                              "1"
                                          ? true
                                          : false,
                                  onChanged: (bool? value) {},
                                ))
                              ],
                            ),
                          )),
                ],
              )),
        );
      }),
    );
  }
}
