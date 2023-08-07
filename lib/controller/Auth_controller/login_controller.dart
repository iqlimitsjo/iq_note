import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/status_request.dart';
import '../../core/constant/routes.dart';
import '../../core/function/handling_data_controller.dart';
import '../../core/function/show_error_auth.dart';
import '../../core/services/services.dart';
import '../../core/shared/user_data.dart';
import '../../data/model/user_model.dart';
import '../../data/source/remote/user_data/user_remote.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isVisable = false;
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  bool? bio;

  UserData userData = UserData(Get.find());

  togglePassword() {
    isVisable = !isVisable;

    update();
  }

  getUserData() async {
    userDataList.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await userData.getUserData("users");
    statusRequest = handlingFirebaseData(response.$2);
    if (statusRequest == StatusRequest.success &&
        response.$2.message == "success") {
      for (var element in response.$1) {
        userDataList.add(UserModel.fromFirestore(element));
      }
      statusRequest = StatusRequest.success;
    }

    print(response.$2.message);
    print(userDataList.toString());

    update();
  }

  login() async {
    var formCurrent = formKey.currentState;
    if (formCurrent!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      try {
        final credential =
            await myServices.firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        myServices.user = credential.user!;
        getUserData();
        print(myServices.user);
        if (myServices.user.displayName == null) {
          Get.offNamed(AppRoutes.userInfo, arguments: {
            'email': emailController.text.trim(),
            'password': passwordController.text.trim(),
          });
        } else {
          Get.offNamed(AppRoutes.home);
        }

        statusRequest = StatusRequest.success;
        update();
      } on FirebaseAuthException catch (e) {
        statusRequest = StatusRequest.failed;
        showAuthError(errorCode: e.code);
      }
    }
    update();
  }

  loginWithBiometrics() async {
    if (await myServices.authenticate()) {
      statusRequest = StatusRequest.loading;
      update();
      try {
        final credential =
            await myServices.firebaseAuth.signInWithEmailAndPassword(
          email: myServices.sharedPref.getString("email")!,
          password: myServices.sharedPref.getString("password")!,
        );
        myServices.user = credential.user!;
        Get.offNamed(AppRoutes.home);
        statusRequest = StatusRequest.success;
        update();
      } on FirebaseAuthException catch (e) {
        statusRequest = StatusRequest.failed;
        showAuthError(errorCode: e.code);
      }
    }
  }

  @override
  void onInit() {
    bio = myServices.sharedPref.getBool("bio");
    print(bio);
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
