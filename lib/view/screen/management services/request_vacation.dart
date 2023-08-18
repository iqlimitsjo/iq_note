import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../controller/management_controller/request_controller.dart';
import '../../../core/class/handling_data_view.dart';
import '../../../core/constant/strings.dart';
import '../../widget/request_mangment/reason_text_field.dart';
import '../../widget/request_mangment/request_start_date.dart';
import '../../widget/request_mangment/sign_board.dart';
import '../../widget/request_mangment/time_range.dart';
import '../../widget/request_mangment/vacation_slider.dart';
import '../../widget/shared/button.dart';

class RequestVacation extends StatelessWidget {
  const RequestVacation({super.key});

  @override
  Widget build(BuildContext context) {
    RequestController controller = Get.put(RequestController());
    return Scaffold(
      appBar: AppBar(
        // title: const Text(AppStrings.requestVacation),
        title: Text(controller.getTitle()),
        centerTitle: true,
      ),
      body: GetBuilder<RequestController>(
        assignId: true,
        builder: (controller) {
          return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: FormBuilder(
                key: controller.formKey,
                onChanged: () {
                  controller.formKey.currentState!.save();
                  controller.update();
                },
                autovalidateMode: AutovalidateMode.disabled,
                // skipDisabled: true,
                clearValueOnUnregister: true,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    const RequestStartDate(),
                    if (controller.isFromVacation) const VacationSlider(),
                    const SizedBox(height: 20),
                    if (controller.isFromLeave || controller.isFromDelay)
                      const TimeRange(),
                    const ReasonTextField(),
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: const Text("التوقيع")),
                    const SignBoard(),
                    CustomButton(
                        onPressed: () => controller.sendRequest(),
                        title: AppStrings.send)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
