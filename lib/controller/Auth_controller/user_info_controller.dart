import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/class/status_request.dart';
import '../../core/constant/strings.dart';
import '../../core/function/handling_data_controller.dart';
import '../../core/function/show_snackbar.dart';
import '../../core/services/services.dart';
import '../../data/source/remote/user_data/user_remote.dart';

class UserInfoController extends GetxController {
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  File? file;
  late bool biometricEnabled;
  MyServices myServices = Get.find();
  String? email;
  String? password;

  UserData userData = UserData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  String? downloadUrl;

  toggleBiometric(bool val) async {
    if (await myServices.authenticate()) {
      biometricEnabled = val;
      myServices.sharedPref.setBool('bio', val);
      myServices.sharedPref.setString('email', email!);
      myServices.sharedPref.setString('password', password!);
      update();
    }
  }

  selectImage(ImageSource imageSource) async {
    XFile? xFile = await ImagePicker().pickImage(source: imageSource);
    if (xFile?.path == null) {
      showSnackBar(
        AppStrings.error,
        "لم تقم بإختيار صورة",
        Icons.info_outline,
      );
    } else {
      file = File(xFile!.path);
      Get.back();
    }
    update();
  }

  uploadImage() async {
    if (file != null) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await userData.uploadFile(file!);
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

  saveData() async {
    if (formStateKey.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      myServices.user.updateDisplayName(userName.text.trim());
      myServices.user.reload();

      await uploadImage();
      var response = await userData.updateUser('users', myServices.user.uid, {
        "user_name": userName.text.trim(),
        "user_phone": phoneNumber.text.trim(),
        "user_images": downloadUrl,
      });

      statusRequest = handlingFirebaseData(response);
      if (statusRequest == StatusRequest.success) {
        showSnackBar("تم بنجاح", "تم تعديل  بنجاح", Icons.edit);

        update();
      }
      update();
    }
  }

  @override
  void onInit() {
    biometricEnabled = myServices.sharedPref.getBool('bio') ?? false;
    email = Get.arguments['email'];
    password = Get.arguments['password'];

    super.onInit();
  }
}
