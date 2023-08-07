import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../controller/Auth_controller/user_info_controller.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/constant/strings.dart';

UserInfoController controller = Get.find();

showBottomSheetImagePicker() {
  Get.bottomSheet(
    Container(
      color: AppColor.backgroundColor,
      height: 150,
      width: double.infinity,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              controller.selectImage(ImageSource.gallery);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                AppStrings.gallery,
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.selectImage(ImageSource.camera);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                AppStrings.camera,
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
