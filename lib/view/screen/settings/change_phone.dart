import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/settings_controller/change_phone_controller.dart';
import '../../../core/class/handling_data_view.dart';
import '../../../core/constant/strings.dart';
import '../../../core/function/valid_input.dart';
import '../../widget/shared/button.dart';
import '../../widget/shared/input_field.dart';

class ChangeUserPhone extends StatelessWidget {
  const ChangeUserPhone({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChangePhoneController());
    return Scaffold(
      appBar: AppBar(
        title: Text('phone'.tr),
      ),
      body: GetBuilder<ChangePhoneController>(
        builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Form(
                key: controller.formKey,
                child: ListView(
                  children: [
                    CustomInputField(
                      title: AppStrings.phone,
                      hint: 'أدخل رقم الهاتف الجديد',
                      icon: const Icon(Icons.person),
                      myController: controller.userPhoneController,
                      valid: (val) {
                        return validInput(val!, 5, 50, 'phone');
                      },
                      type: TextInputType.phone,
                    ),
                    CustomButton(
                      title: AppStrings.save,
                      onPressed: () {
                        controller.savePhone();
                      },
                    ),
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
