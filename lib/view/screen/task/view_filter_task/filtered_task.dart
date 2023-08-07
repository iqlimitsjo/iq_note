import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../../../controller/filtered_task_controller/filtered_task_controller.dart';
import '../../../../core/function/show_bottom_sheet.dart';
import '../../../widget/shared/app_bar.dart';
import '../../../widget/shared/app_drawer.dart';
import '../../../widget/shared/task_tile.dart';

class FilteredTask extends StatelessWidget {
  const FilteredTask({super.key});

  @override
  Widget build(BuildContext context) {
    FilteredTaskController controller = Get.put(FilteredTaskController());
    return Scaffold(
      appBar: customAppBar(
        title: controller.selectedDate!,
        isHome: false,
      ),
      drawer: const AppDrawer(),
      body: ListView(
        children: [
          ...List.generate(controller.data.length, (index) {
            var task = controller.data[index];
            return AnimationConfiguration.staggeredList(
              duration: const Duration(milliseconds: 500),
              position: index,
              child: SlideAnimation(
                horizontalOffset: 300,
                child: GestureDetector(
                  onTap: () {
                    showCustomBottomSheet(
                      task: task,
                      onUpdateTap: () {
                        controller.updateTask(
                            controller.data[index].id!,
                            controller.data[index].taskIsCompleted == "0"
                                ? "1"
                                : "0");
                        Get.isBottomSheetOpen == true ? Get.back() : Get.back();
                      },
                      onDeleteTap: () {
                        controller.deleteTask(controller.data[index].id!);
                        Get.isBottomSheetOpen! ? Get.back() : Get.back();
                      },
                    );
                  },
                  child: CustomTaskTile(
                    task: task,
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
