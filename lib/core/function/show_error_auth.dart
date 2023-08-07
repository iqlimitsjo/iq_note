import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';

import '../constant/strings.dart';
import 'custom_dialog.dart';

showAuthError({required String errorCode}) {
  if (errorCode == 'user-not-found') {
    customDialog(
        context: Get.context!,
        dialogType: DialogType.error,
        title: AppStrings.error,
        description:
            "هذا المستخدم غير موجود الرجاء التأكد من البريد الالكتروني");
  } else if (errorCode == 'wrong-password') {
    customDialog(
        context: Get.context!,
        dialogType: DialogType.error,
        title: AppStrings.error,
        description: "الرقم السري خاطئ");
  } else if (errorCode == 'email-already-in-use') {
    customDialog(
        context: Get.context!,
        dialogType: DialogType.error,
        title: AppStrings.error,
        description: "البريد الالكتروني مستخدم من قبل");
  } else if (errorCode == 'invalid-email') {
    customDialog(
        context: Get.context!,
        dialogType: DialogType.error,
        title: AppStrings.error,
        description: "بريد الكتروني خاطئ");
  } else if (errorCode == 'weak-password') {
    customDialog(
        context: Get.context!,
        dialogType: DialogType.error,
        title: AppStrings.error,
        description: "الرقم السري ضعيف");
  } else {
    customDialog(
        context: Get.context!,
        dialogType: DialogType.error,
        title: AppStrings.error,
        description: "خطا غير معروف يرجى المحاولة لاحقا");
  }
}
