import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/add_task_controller/add_task_controller.dart';
import '../../../core/constant/strings.dart';
import '../../../data/source/static/static_repeat_list.dart';
import 'custom_dropdown.dart';

class RepeatDropdown extends GetView<AddTaskController> {
  const RepeatDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDropdownField(
      title: AppStrings.repeat,
      onChanged: (String? val) {
        controller.selectedRepeat = val!;
        print(controller.selectedRepeat);
      },
      items: [
        ...List.generate(
            repeatList.length,
            (index) => DropdownMenuItem(
                  value: repeatList[index].value,
                  child: Text(repeatList[index].title),
                )),
      ],
    );
  }
}
