import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/add_task_controller/add_task_controller.dart';

class ImagePickerSection extends StatelessWidget {
  const ImagePickerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTaskController>(builder: (controller) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => controller.selectImage(ImageSource.camera),
                icon: const Icon(
                  Icons.camera_alt,
                  size: 40,
                ),
              ),
              IconButton(
                onPressed: () => controller.selectImage(ImageSource.gallery),
                icon: const Icon(
                  Icons.image_outlined,
                  size: 40,
                ),
              ),
            ],
          ),
          if (controller.selectedImage != null)
            Row(
              children: [
                TextButton(
                    onPressed: controller.deleteImage, child: const Text("X")),
                Text("${controller.selectedImage}.jpg"),
              ],
            )
        ],
      );
    });
  }
}
