import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/class/crud_firebase.dart';
import '../../core/class/status_request.dart';
import '../../core/function/custom_dialog.dart';
import '../../core/function/show_error_auth.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email;
  StatusRequest statusRequest = StatusRequest.none;

  resetPassword() async {
    if (formKey.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      try {
        await myServices.firebaseAuth
            .sendPasswordResetEmail(email: emailController.text)
            .then((value) {
          customDialog(
              context: Get.context!,
              dialogType: DialogType.success,
              title: "تم",
              description:
                  "تم ارسال تغيير الرقم السري الى البريد الالكتروني $email");

          return statusRequest = StatusRequest.success;
        });

        update();
      } on FirebaseAuthException catch (e) {
        statusRequest = StatusRequest.failed;
        showAuthError(errorCode: e.code);
      }
    }
    update();
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    emailController.text = email!;
    print(email);
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
