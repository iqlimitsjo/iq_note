import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/notification_controller/send_to_user_controller.dart';
import '../../../core/constant/strings.dart';
import '../../../data/source/static/static_department_list.dart';
import '../../widget/shared/app_bar.dart';
import '../../widget/shared/app_drawer.dart';

class SendNotifications extends StatelessWidget {
  const SendNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    SendNotificationsToUserController controller =
        Get.put(SendNotificationsToUserController());
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: customAppBar(title: "إرسال إشعار", isHome: false),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            ...List.generate(
                controller.userList.length,
                (index) => Container(
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        isThreeLine: true,
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(width: 1.2, color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        title: Text(
                            controller.userList[index].userName ?? "بلا إسم"),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.userList[index].userEmail!),
                            Text(departmentList[int.parse(
                                    controller.userList[index].userDepartment!)]
                                .title),
                          ],
                        ),
                        trailing: ElevatedButton(
                          onPressed: () =>
                              controller.sendTaskNotificationToUser(
                                  topicId: controller.userList[index].userId!),
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.green),
                          ),
                          child: const Text(AppStrings.send),
                        ),
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}
