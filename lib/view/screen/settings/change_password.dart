import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/function/valid_input.dart';
import '../../../controller/settings_controller/change_password_controller.dart';
import '../../../core/class/handling_data_view.dart';
import '../../../core/constant/strings.dart';
import '../../widget/shared/button.dart';
import '../../widget/shared/input_field.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ChangePasswordController());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "إعادة ضبط الرقم السري",
          ),
        ),
        body: GetBuilder<ChangePasswordController>(
            builder: (controller) => HandlingDataRequest(
                  statusRequest: controller.statusRequest,
                  widget: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: Form(
                      key: controller.formState,
                      child: ListView(
                        children: [
                          const SizedBox(height: 30),
                          // const CustomHeader(headerText: 'resetPasswordHeader'),
                          // const SizedBox(height: 10),
                          // const CustomBody(bodyText: 'resetPasswordBody'),
                          // const SizedBox(height: 20),
                          //
                          GetBuilder<ChangePasswordController>(
                            builder: (controller) => CustomInputField(
                              isExpanded: false,
                              valid: (val) {
                                return validInput(val!, 5, 50, 'password');
                              },
                              obscureText: controller.isVisiblePassword,
                              onTapIcon: () {
                                controller.showPassword();
                              },
                              title: AppStrings.password,
                              hint: 'أدخل الرقم السري الجديد',
                              icon: const Icon(Icons.lock_outline),
                              myController: controller.password,
                            ),
                          ),
                          GetBuilder<ChangePasswordController>(
                            builder: (controller) => CustomInputField(
                              valid: (val) {
                                return validInput(val!, 5, 50, 'password');
                              },
                              isExpanded: false,
                              obscureText: controller.isVisiblePassword,
                              onTapIcon: () {
                                controller.showPassword();
                              },
                              title: "إعادة الرقم السري",
                              hint: 'أعد ادخال الرقم السري الجديد',
                              icon: const Icon(Icons.lock_outline),
                              myController: controller.rePassword,
                            ),
                          ),
                          CustomButton(
                              title: AppStrings.save,
                              onPressed: () {
                                controller.savePassword();
                              }),
                        ],
                      ),
                    ),
                  ),
                )));
  }
}
