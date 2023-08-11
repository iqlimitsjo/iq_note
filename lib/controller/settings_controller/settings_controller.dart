import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/class/status_request.dart';
import '../../core/constant/routes.dart';
import '../../core/constant/strings.dart';
import '../../core/function/show_snackbar.dart';
import '../../core/services/services.dart';
import '../../data/source/remote/user_data/user_remote.dart';

class SettingsController extends GetxController {
  File? file;
  bool isVisable = false;
  MyServices myServices = Get.find();
  UserData userData = UserData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  String? downloadUrl;
  late bool biometricEnabled;

  selectImage() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile?.path == null) {
      showSnackBar(
        AppStrings.error,
        "لم تقم بإختيار صورة",
        Icons.info_outline,
      );
    } else {
      file = File(xFile!.path);
      update();
    }
    update();
  }

  togglePassword() {
    isVisable = !isVisable;

    update();
  }

  // updatePassword() async {
  //   if (userPassword.text != "" &&
  //       userController.formStateKey.currentState!.validate()) {
  //     userController.myServices.user.updatePassword(userPassword.text.trim());
  //   }
  // }

  uploadImage(File? userFile) async {
    if (userFile != null) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await userData.uploadFile(userFile, myServices.user.uid);
      if (response.$2.message == "success") {
        downloadUrl = response.$1;
        myServices.user.updatePhotoURL(response.$1);
        showSnackBar("تم", "تم رفع الصورة بنجاح", Icons.done);

        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.failed;
      }
    }
  }

  saveChange() async {
    await uploadImage(file);
    if (file != null) {
      await userData.updateUser('users', myServices.user.uid, {
        "user_images": downloadUrl,
      });
    }

    myServices.user.reload();
  }

  toggleBiometric(bool val) async {
    if (await myServices.authenticate()) {
      biometricEnabled = val;
      myServices.sharedPref.setBool('bio', val);
      update();
    }
  }

  goToChangeEmail() {
    Get.toNamed(AppRoutes.changeEmail);
  }

  goToChangeUserName() {
    Get.toNamed(AppRoutes.changeUserName);
  }

  goToChangePhone() {
    Get.toNamed(AppRoutes.changeUserPhone);
  }

  goToChangePassword() {
    Get.toNamed(AppRoutes.changeUserPassword);
  }

  @override
  void onInit() {
    biometricEnabled = myServices.sharedPref.getBool('bio') ?? false;

    super.onInit();
  }
}
