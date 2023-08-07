import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/users_controller/add_user_controller.dart';
import '../../../core/class/handling_data_view.dart';
import '../../../core/constant/strings.dart';
import '../../../core/function/valid_input.dart';
import '../../../data/source/static/static_department_list.dart';
import '../../widget/shared/app_bar.dart';
import '../../widget/shared/app_drawer.dart';
import '../../widget/shared/button.dart';
import '../../widget/shared/input_field.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddUserController());
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: customAppBar(
        title: AppStrings.addUser,
        isHome: false,
      ),
      body: GetBuilder<AddUserController>(builder: (controller) {
        return HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Form(
            key: controller.formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CustomInputField(
                      myController: controller.email,
                      type: TextInputType.emailAddress,
                      title: AppStrings.email,
                      hint: AppStrings.emailHint,
                      icon: const Icon(Icons.email_outlined),
                      valid: (val) {
                        return validInput(val!, 7, 50, 'email');
                      },
                    ),
                  ),
                  ...List.generate(
                    departmentList.length,
                    (index) => ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(departmentList[index].title),
                      leading: Radio(
                        activeColor: Colors.green,
                        value: departmentList[index].value,
                        groupValue: controller.selectedDepartment,
                        onChanged: (value) {
                          controller.selectedDepartment = value!;
                          controller.update();
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: CustomButton(
                      onPressed: () => controller.adUser(),
                      title: AppStrings.save,
                      color: Colors.green,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
