import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/status_request.dart';
import '../../core/function/custom_dialog.dart';
import '../../core/function/show_error_auth.dart';
import '../../core/function/show_snackbar.dart';
import '../../core/services/services.dart';
import '../../data/source/remote/user_data/user_remote.dart';

class ChangePasswordController extends GetxController {
  late TextEditingController password;
  late TextEditingController rePassword;

  bool isVisiblePassword = true;

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  UserData userData = UserData(Get.find());
  MyServices myServices = Get.find();

  showPassword() {
    isVisiblePassword = !isVisiblePassword;
    update();
  }

  savePassword() async {
    if (formState.currentState!.validate()) {
      if (password.text == rePassword.text) {
        statusRequest = StatusRequest.loading;
        update();
        try {
          await myServices.user
              .updatePassword(password.text.trim())
              .then((value) async {
            statusRequest = StatusRequest.success;

            myServices.sharedPref.setString('password', password.text.trim());
            showSnackBar("تم بنجاح", "تم تعديل  بنجاح", Icons.edit);
            update();
          });
        } on FirebaseException catch (e) {
          statusRequest = StatusRequest.failed;
          print(e.code);
          showAuthError(errorCode: e.code);
          update();
        }
      } else {
        customDialog(
            context: Get.context!,
            dialogType: DialogType.error,
            title: 'إعادة ضبط الرقم السري',
            description: 'الرقم السري غير متطابق');
      }
    } else {}
    update();
  }

  @override
  void onInit() {
    password = TextEditingController();
    rePassword = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    password.dispose();
    rePassword.dispose();
    super.dispose();
  }
}
