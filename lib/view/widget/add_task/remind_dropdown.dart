import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/add_task_controller/add_task_controller.dart';
import '../../../core/constant/strings.dart';
import '../../../data/source/static/ststic_remind_list.dart';
import 'custom_dropdown.dart';

class RemindDropdown extends GetView<AddTaskController> {
  const RemindDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDropdownField(
      title: AppStrings.remind,
      onChanged: (String? val) {
        controller.selectedRemind = val!;
        print(controller.selectedRemind);
      },
      items: [
        ...List.generate(
            remindList.length,
            (index) => DropdownMenuItem(
                  value: remindList[index].value,
                  child: Text(remindList[index].title),
                )),
      ],
    );
  }
}
