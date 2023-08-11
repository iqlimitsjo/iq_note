import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/Auth_controller/user_info_controller.dart';
import '../../../../core/constant/color.dart';
import '../../../../generated/assets.dart';
import '../login/show_bottom_sheet.dart';

class HeaderImagePicker extends StatelessWidget {
  const HeaderImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 25),
          Stack(
            children: [
              GetBuilder<UserInfoController>(builder: (controller) {
                return Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(0, 10))
                      ],
                      image: controller.file == null
                          ? const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(Assets.imagesAvatar),
                            )
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(controller.file!),
                            )),
                );
              }),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    showBottomSheetImagePicker();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      shape: BoxShape.circle,
                      color: AppColor.primaryClr,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
