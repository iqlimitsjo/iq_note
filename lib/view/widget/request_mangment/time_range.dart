import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../controller/management_controller/request_controller.dart';

class TimeRange extends GetView<RequestController> {
  const TimeRange({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilderDateTimePicker(
          name: 'start_time',
          inputType: InputType.time,
          controller: controller.startTimeController,
          initialValue: DateTime.now().add(const Duration(hours: 1)),
          timePickerInitialEntryMode: TimePickerEntryMode.dial,
          validator: (val) {
            if (!GetUtils.isDateTime(val.toString())) {
              return "أدخل وقت البدء لطلبك";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: 'وقت بدء الطلب',
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                controller.formKey.currentState!.fields['start_time']
                    ?.didChange(null);
              },
            ),
          ),
          style: const TextStyle(fontSize: 22),
        ),
        FormBuilderDateTimePicker(
          name: 'end_time',
          inputType: InputType.time,
          controller: controller.endTimeController,
          initialValue: DateTime.now().add(const Duration(hours: 2)),
          timePickerInitialEntryMode: TimePickerEntryMode.dial,
          validator: (val) {
            if (!GetUtils.isDateTime(val.toString())) {
              return "أدخل وقت إنتهاء لطلبك";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: 'وقت إنتهاء الطلب',
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                controller.formKey.currentState!.fields['end_time']
                    ?.didChange(null);
              },
            ),
          ),
          style: const TextStyle(fontSize: 22),
        ),
      ],
    );
  }
}
