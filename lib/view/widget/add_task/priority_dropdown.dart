import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iq_note/view/widget/add_task/custom_dropdown.dart';

import '../../../controller/add_task_controller/add_task_controller.dart';
import '../../../core/constant/strings.dart';
import '../../../data/source/static/static_priority_list.dart';

class PriorityDropDown extends GetView<AddTaskController> {
  const PriorityDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDropdownField(
      title: AppStrings.priority,
      onChanged: (String? val) {
        controller.selectedPriority = val!;
      },
      items: [
        ...List.generate(
            priorityList.length,
            (index) => DropdownMenuItem(
                  value: priorityList[index].value,
                  child: Text(priorityList[index].title),
                )),
      ],
    );
  }
}
