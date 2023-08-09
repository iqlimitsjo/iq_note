import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/Auth_controller/user_info_controller.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/strings.dart';
import '../../../../core/function/valid_input.dart';
import '../../../widget/Auth/user_Info/header_image_picker.dart';
import '../../../widget/shared/button.dart';
import '../../../widget/shared/input_field.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserInfoController());
    return Scaffold(
      body: GetBuilder<UserInfoController>(builder: (controller) {
        return HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Form(
              key: controller.formStateKey,
              child: ListView(
                children: [
                  const HeaderImagePicker(),
                  const SizedBox(height: 50),
                  CustomInputField(
                    myController: controller.userName,
                    title: AppStrings.userName,
                    hint: AppStrings.userNameHint,
                    icon: const Icon(Icons.person_2),
                    valid: (val) {
                      return validInput(val!, 4, 25, 'text');
                    },
                  ),
                  CustomInputField(
                    myController: controller.phoneNumber,
                    title: AppStrings.phone,
                    type: TextInputType.phone,
                    hint: AppStrings.phoneHint,
                    icon: const Icon(Icons.numbers),
                    valid: (val) {
                      return validInput(val!, 4, 25, 'phone');
                    },
                  ),
                  SwitchListTile(
                    activeColor: Colors.green,
                    title: const Text(AppStrings.enableBiometrics),
                    value: controller.biometricEnabled,
                    onChanged: (value) {
                      controller.toggleBiometric(value);
                    },
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                      onPressed: () => controller.saveData(),
                      title: AppStrings.save),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
