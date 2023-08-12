import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/users_controller/add_user_controller.dart';
import '../../../core/class/handling_data_view.dart';
import '../../../core/constant/strings.dart';
import '../../../core/function/valid_input.dart';
import '../../../data/source/static/static_department_list.dart';
import '../../../data/source/static/static_user_level_list.dart';
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
              child: ListView(
                children: [
                  const SizedBox(height: 40),
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
                  const Text("القسم :",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  ...List.generate(
                    departmentList.length,
                    (index) => ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        departmentList[index].title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
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
                  const Text("المستوى :",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  ...List.generate(
                    userLevelList.length,
                    (index) => ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        userLevelList[index].title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(userLevelList[index].description),
                      leading: Radio(
                        activeColor: Colors.green,
                        value: userLevelList[index].value,
                        groupValue: controller.selectedLevel,
                        onChanged: (value) {
                          controller.selectedLevel = value!;
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
