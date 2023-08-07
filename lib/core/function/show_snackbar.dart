import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar(
  String title,
  String message,
  IconData icon,
) {
  return Get.showSnackbar(
    GetSnackBar(
      title: title,
      message: message,
      icon: Icon(
        icon,
        color: Colors.green,
      ),
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.GROUNDED,
    ),
  );
}
