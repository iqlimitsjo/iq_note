import "package:flutter/material.dart";
import 'package:get/get.dart';

import '../../../controller/settings_controller/change_email_controller.dart';
import '../../../core/class/handling_data_view.dart';
import '../../../core/constant/strings.dart';
import '../../../core/function/valid_input.dart';
import '../../widget/shared/button.dart';
import '../../widget/shared/input_field.dart';

class ChangeEmail extends StatelessWidget {
  const ChangeEmail({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChangeEmailController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppStrings.email),
      ),
      body: GetBuilder<ChangeEmailController>(builder: (controller) {
        return HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Form(
              key: controller.formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 30),
                  CustomInputField(
                    title: AppStrings.email,
                    hint: 'أدخل البريد الالكتروني الجديد',
                    icon: const Icon(Icons.alternate_email_rounded),
                    myController: controller.userTextController,
                    valid: (val) {
                      return validInput(val!, 5, 50, 'email');
                    },
                    type: TextInputType.emailAddress,
                  ),
                  CustomButton(
                    title: AppStrings.save,
                    onPressed: () {
                      controller.saveEmail();
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
