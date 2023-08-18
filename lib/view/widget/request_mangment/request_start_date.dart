import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../controller/management_controller/request_controller.dart';

class RequestStartDate extends GetView<RequestController> {
  const RequestStartDate({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      name: 'date',
      validator: (val) {
        if (!GetUtils.isDateTime(val.toString())) {
          return "أدخل تاريخ البدء لطلبك";
        }
        return null;
      },
      controller: controller.dateController,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialValue: DateTime.now().add(const Duration(days: 1)),
      inputType: InputType.date,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().subtract(const Duration(days: 2)),
      decoration: InputDecoration(
        labelText: 'تاريخ بدء الطلب',
        suffixIcon: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            controller.formKey.currentState!.fields['date']?.didChange(null);
          },
        ),
      ),
      style: const TextStyle(fontSize: 22),
    );
  }
}
