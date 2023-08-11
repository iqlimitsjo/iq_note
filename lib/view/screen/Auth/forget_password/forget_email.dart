import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/Auth_controller/forget_password_controller.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/strings.dart';
import '../../../../core/function/valid_input.dart';
import '../../../widget/shared/app_bar.dart';
import '../../../widget/shared/button.dart';
import '../../../widget/shared/input_field.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: customAppBar(
        title: AppStrings.resetPassword,
        isHome: false,
      ),
      body: GetBuilder<ForgetPasswordController>(builder: (controller) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  CustomInputField(
                      title: AppStrings.email,
                      hint: AppStrings.emailHint,
                      myController: controller.emailController,
                      icon: const Icon(Icons.lock_reset),
                      valid: (val) {
                        return validInput(val!, 5, 50, 'email');
                      }),
                  CustomButton(
                      onPressed: controller.resetPassword,
                      title: AppStrings.send)
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
