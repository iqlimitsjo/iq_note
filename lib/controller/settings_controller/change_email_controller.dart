import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/status_request.dart';
import '../../core/function/handling_data_controller.dart';
import '../../core/function/show_error_auth.dart';
import '../../core/function/show_snackbar.dart';
import '../../core/services/services.dart';
import '../../data/source/remote/user_data/user_remote.dart';

class ChangeEmailController extends GetxController {
  TextEditingController userTextController = TextEditingController();
  UserData userData = UserData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  saveEmail() async {
    if (formKey.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      try {
        await myServices.user
            .updateEmail(userTextController.text.trim())
            .then((value) async {
          var response =
              await userData.updateUser('users', myServices.user.uid, {
            "user_email": userTextController.text.trim(),
          });
          statusRequest = handlingFirebaseData(response);
          if (statusRequest == StatusRequest.success) {
            myServices.sharedPref
                .setString('email', userTextController.text.trim());
            showSnackBar("تم بنجاح", "تم تعديل  بنجاح", Icons.edit);

            update();
          }
        });
      } on FirebaseException catch (e) {
        statusRequest = StatusRequest.failed;
        showAuthError(errorCode: e.code);
      }
    } else {}
    update();
  }

  @override
  void dispose() {
    userTextController.dispose();
    super.dispose();
  }
}
