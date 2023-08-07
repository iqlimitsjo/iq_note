import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../controller/add_task_controller/add_task_controller.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/strings.dart';
import '../../../../core/function/valid_input.dart';
import '../../../../data/source/static/static_color_list.dart';
import '../../../widget/add_task/color_palette.dart';
import '../../../widget/add_task/image_picker_section.dart';
import '../../../widget/add_task/priority_dropdown.dart';
import '../../../widget/add_task/record_section.dart';
import '../../../widget/add_task/remind_dropdown.dart';
import '../../../widget/add_task/repeat_dropdown.dart';
import '../../../widget/shared/app_bar.dart';
import '../../../widget/shared/app_drawer.dart';
import '../../../widget/shared/button.dart';
import '../../../widget/shared/input_field.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddTaskController());

    return Scaffold(
      appBar: customAppBar(
        title: AppStrings.addN,
        isHome: false,
      ),
      drawer: const AppDrawer(),
      body: Container(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 30),
        child: GetBuilder<AddTaskController>(
          builder: (controller) {
            return HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: Form(
                key: controller.formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 10),
                    CustomInputField(
                      title: AppStrings.addNoteTitle,
                      hint: AppStrings.addNoteTitleHint,
                      icon: const Icon(Icons.note_alt_outlined),
                      myController: controller.titleController,
                      valid: (val) {
                        return validInput(val!, 4, 60, 'note');
                      },
                    ),
                    CustomInputField(
                      title: AppStrings.addNoteBody,
                      hint: AppStrings.addNoteBodyHint,
                      icon: const Icon(Icons.note_add_outlined),
                      myController: controller.noteController,
                      valid: (val) {
                        return validInput(val!, 4, 10000, 'note');
                      },
                    ),
                    CustomInputField(
                      title: AppStrings.date,
                      isReadOnly: true,
                      hint: DateFormat.yMd().format(controller.selectedDate),
                      icon: const Icon(Icons.date_range_outlined),
                      valid: (val) {
                        return;
                      },
                      onTapIcon: () async {
                        DateTime? dataPicker = await showDatePicker(
                          context: context,
                          initialDate: controller.selectedDate,
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2035),
                          helpText: "إختر التاريخ",
                          confirmText: AppStrings.ok,
                          cancelText: AppStrings.cancel,
                        );
                        controller.updateSelectedDate(dataPicker);
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomInputField(
                            title: AppStrings.startTime,
                            isReadOnly: true,
                            hint: controller.startTime,
                            icon: const Icon(Icons.access_time),
                            valid: (val) {
                              return;
                            },
                            onTapIcon: () {
                              controller.getTimeFromUser(isStartTime: true);
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomInputField(
                            title: AppStrings.endTime,
                            isReadOnly: true,
                            hint: controller.endTime,
                            icon: const Icon(Icons.access_time),
                            valid: (val) {
                              return;
                            },
                            onTapIcon: () async {
                              controller.getTimeFromUser(isStartTime: false);
                            },
                          ),
                        ),
                      ],
                    ),
                    const PriorityDropDown(),
                    const SizedBox(height: 10),
                    const RepeatDropdown(),
                    const SizedBox(height: 10),
                    const RemindDropdown(),
                    const SizedBox(height: 10),
                    const Text(AppStrings.addImage,
                        style: TextStyle(fontSize: 20)),
                    const ImagePickerSection(),
                    const Text(AppStrings.addRecord,
                        style: TextStyle(fontSize: 20)),
                    const RecordSection(),
                    const Text(AppStrings.color,
                        style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    ColorPalette(colors: colorsList),
                    const SizedBox(height: 20),
                    CustomButton(
                      onPressed: () {
                        controller.adTask();
                      },
                      title: AppStrings.addNote,
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
