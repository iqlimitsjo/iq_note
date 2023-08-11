import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/settings_controller/change_user_name_controller.dart';
import '../../../core/class/handling_data_view.dart';
import '../../../core/constant/strings.dart';
import '../../../core/function/valid_input.dart';
import '../../widget/shared/button.dart';
import '../../widget/shared/input_field.dart';

class ChangeUserName extends StatelessWidget {
  const ChangeUserName({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChangeUserNameController());
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.userName),
        centerTitle: true,
      ),
      body: GetBuilder<ChangeUserNameController>(builder: (controller) {
        return HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Form(
              key: controller.formKey,
              child: ListView(
                children: [
                  CustomInputField(
                      title: AppStrings.username,
                      hint: "أدخل اسم المستخدم الجديد",
                      icon: const Icon(Icons.person),
                      myController: controller.userTextController,
                      valid: (val) {
                        return validInput(val!, 4, 50, 'text');
                      }),
                  CustomButton(
                    title: AppStrings.save,
                    onPressed: () {
                      controller.saveUserName();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
