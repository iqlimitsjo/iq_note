import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/Auth_controller/login_controller.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/strings.dart';
import '../../../../core/function/valid_input.dart';
import '../../../widget/Auth/login/header_image.dart';
import '../../../widget/shared/button.dart';
import '../../../widget/shared/input_field.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(body: GetBuilder<LoginController>(builder: (controller) {
      return HandlingDataRequest(
        statusRequest: controller.statusRequest,
        widget: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: controller.formKey,
            child: ListView(
              children: [
                const ImageHeader(),
                CustomInputField(
                  isExpanded: false,
                  hint: AppStrings.emailHint,
                  icon: const Icon(Icons.email),
                  title: AppStrings.email,
                  myController: controller.emailController,
                  valid: (val) {
                    validInput(val!, 7, 35, "email");
                    return null;
                  },
                ),
                GetBuilder<LoginController>(builder: (controller) {
                  return CustomInputField(
                    isExpanded: false,
                    hint: AppStrings.passwordHint,
                    icon: const Icon(Icons.password),
                    title: AppStrings.password,
                    obscureText: !controller.isVisable,
                    onTapIcon: () => controller.togglePassword(),
                    myController: controller.passwordController,
                    valid: (val) {
                      validInput(val!, 4, 35, "password");
                      return null;
                    },
                  );
                }),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    AppStrings.forgetPassword,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
                CustomButton(
                  onPressed: () => controller.login(),
                  title: AppStrings.login,
                  color: Colors.green,
                  maxWidth: true,
                ),
                const SizedBox(height: 10),
                if (controller.bio == true)
                  const Text(
                    AppStrings.loginWithBiomatric,
                    textAlign: TextAlign.center,
                  ),
                if (controller.bio == true)
                  IconButton(
                      onPressed: () => controller.loginWithBiometrics(),
                      icon: const Icon(
                        Icons.fingerprint_rounded,
                        size: 60,
                        color: Colors.green,
                      ))
              ],
            ),
          ),
        ),
      );
    }));
  }
}
