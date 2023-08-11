import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/status_request.dart';
import '../../core/function/handling_data_controller.dart';
import '../../core/function/show_error_auth.dart';
import '../../core/function/show_snackbar.dart';
import '../../core/services/services.dart';
import '../../data/source/remote/user_data/user_remote.dart';

class ChangeUserNameController extends GetxController {
  TextEditingController userTextController = TextEditingController();

  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  UserData userData = UserData(Get.find());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  saveUserName() async {
    if (formKey.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      try {
        await myServices.user
            .updateDisplayName(userTextController.text.trim())
            .then((value) async {
          var response =
              await userData.updateUser('users', myServices.user.uid, {
            "user_name": userTextController.text.trim(),
          });
          statusRequest = handlingFirebaseData(response);
          if (statusRequest == StatusRequest.success) {
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
