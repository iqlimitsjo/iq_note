import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/status_request.dart';
import '../../core/constant/routes.dart';
import '../../core/function/handling_data_controller.dart';
import '../../core/function/show_error_auth.dart';
import '../../core/function/show_snackbar.dart';
import '../../core/services/services.dart';
import '../../data/model/user_model.dart';
import '../../data/source/remote/user_data/user_remote.dart';

class AddUserController extends GetxController {
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;

  TextEditingController email = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String selectedDepartment = "0";
  String selectedLevel = "0";

  UserData userData = UserData(Get.find());

  adUser() async {
    if (formKey.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      try {
        var user = await myServices.firebaseAuth.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: "123456",
        );
        var data = UserModel(
          userName: null,
          userEmail: email.text.trim(),
          userPhone: null,
          userLevel: selectedLevel,
          userDepartment: selectedDepartment,
          userImage: null,
        );
        var response = await userData.addUser("users", data, user.user!.uid);
        statusRequest = handlingFirebaseData(response.$1);
        if (StatusRequest.success == statusRequest) {
          print(user.user!.uid);
          showSnackBar(
              "تم بنجاح", 'تم إضافة المستخدم بنجاح ', Icons.person_2_outlined);
          Get.offAndToNamed(AppRoutes.home);
        }
      } on FirebaseAuthException catch (e) {
        statusRequest = StatusRequest.failed;
        showAuthError(errorCode: e.code);
      }

      update();
    }
  }
}
