import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/settings_controller/settings_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/shared/user_data.dart';
import '../../../generated/assets.dart';

class SettingHeader extends StatelessWidget {
  const SettingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(builder: (controller) {
      return Center(
        child: Stack(
          children: [
            controller.file == null
                ? Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: CachedNetworkImage(
                          imageUrl: userDataList[0].userImage!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.fill,
                        )),
                  )
                : Container(
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
                  ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: controller.selectImage,
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
      );
    });
  }
}
