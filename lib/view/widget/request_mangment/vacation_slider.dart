import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../controller/management_controller/request_controller.dart';

class VacationSlider extends GetView<RequestController> {
  const VacationSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderSlider(
      name: 'vacation_length',
      onChanged: controller.onChanged,
      min: 0.0,
      max: 10.0,
      initialValue: 1.0,
      divisions: 10,
      activeColor: Colors.green,
      inactiveColor: Colors.greenAccent[100],
      decoration: const InputDecoration(
        labelText: 'عدد أيام الإجازة',
      ),
      textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      minTextStyle: const TextStyle(fontSize: 15),
      maxTextStyle: const TextStyle(fontSize: 15),
    );
  }
}
