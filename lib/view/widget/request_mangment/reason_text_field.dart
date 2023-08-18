import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../controller/management_controller/request_controller.dart';
import '../../../core/function/valid_input.dart';

class ReasonTextField extends GetView<RequestController> {
  const ReasonTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: controller.reasonController,
      autovalidateMode: AutovalidateMode.disabled,
      name: 'vacation_reason',
      maxLines: 2,
      decoration: InputDecoration(
        labelText: controller.isFromVacation
            ? 'سبب الإجازة'
            : controller.isFromDelay
                ? 'سبب التأخير'
                : "سبب المغادرة",
        suffixIcon: controller.ageHasError
            ? const Icon(Icons.error, color: Colors.red)
            : const Icon(Icons.check, color: Colors.green),
      ),
      validator: (val) {
        return validInput(val ?? "", 5, 200, 'text');
      },
      onChanged: (val) {
        controller.ageHasError = !(controller
                .formKey.currentState?.fields['vacation_reason']
                ?.validate() ??
            false);
        controller.update();
      },
    );
  }
}
