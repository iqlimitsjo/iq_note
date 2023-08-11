import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/status_request.dart';
import '../../core/function/handling_data_controller.dart';
import '../../core/function/show_error_auth.dart';
import '../../core/function/show_snackbar.dart';
import '../../core/services/services.dart';
import '../../data/source/remote/user_data/user_remote.dart';

class ChangePhoneController extends GetxController {
  TextEditingController userPhoneController = TextEditingController();

  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  UserData userData = UserData(Get.find());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  savePhone() async {
    if (formKey.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      try {
        var response = await userData.updateUser('users', myServices.user.uid,
            {"user_phone": userPhoneController.text.trim()});

        statusRequest = handlingFirebaseData(response);
        if (statusRequest == StatusRequest.success) {
          showSnackBar("تم بنجاح", "تم تعديل  بنجاح", Icons.edit);

          update();
        }
      } on FirebaseException catch (e) {
        statusRequest = StatusRequest.failed;
        showAuthError(errorCode: e.code);
      }
    } else {}
    update();
  }

  @override
  void dispose() {
    userPhoneController.dispose();
    super.dispose();
  }
}
