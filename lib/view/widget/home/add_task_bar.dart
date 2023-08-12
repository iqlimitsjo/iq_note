import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/constant/routes.dart';
import '../../../core/constant/strings.dart';
import '../../../data/source/static/user_data.dart';
import '../shared/button.dart';

class AddTaskBar extends StatelessWidget {
  const AddTaskBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMEEEEd('ar').format(DateTime.now()),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                AppStrings.today,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          if (userDataList[0].userLevel == "1" ||
              userDataList[0].userLevel == "2")
            Container(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                  title: ' + ${AppStrings.addN} ',
                  onPressed: () {
                    Get.toNamed(AppRoutes.addTask);
                    // _taskController.getTask();
                  }),
            ),
        ],
      ),
    );
  }
}
