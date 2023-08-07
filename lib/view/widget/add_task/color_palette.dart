import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/add_task_controller/add_task_controller.dart';
import '../../../data/model/color_model.dart';

class ColorPalette extends GetView<AddTaskController> {
  final List<ColorModel> colors;
  final Function()? onTap;

  const ColorPalette({
    super.key,
    required this.colors,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
            colors.length,
            (index) => GestureDetector(
                  onTap: () {
                    controller.selectedColor = colors[index].value;
                    print(controller.selectedColor);
                    controller.update();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: CircleAvatar(
                      backgroundColor: colors[index].color,
                      child: controller.selectedColor == colors[index].value
                          ? const Icon(
                              Icons.done,
                              size: 18,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                )),
      ],
    );
  }
}
