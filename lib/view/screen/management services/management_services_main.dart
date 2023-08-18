import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/management_controller/management_controller.dart';
import '../../../core/constant/strings.dart';
import '../../widget/shared/app_bar.dart';
import '../../widget/shared/app_drawer.dart';
import '../../widget/shared/button.dart';

class ManagementServicesMain extends StatelessWidget {
  const ManagementServicesMain({super.key});

  @override
  Widget build(BuildContext context) {
    ManagementController controller = Get.put(ManagementController());
    return Scaffold(
      appBar: customAppBar(title: AppStrings.managementServices, isHome: false),
      drawer: const AppDrawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "أهلا ${controller.name}",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            const Text("ما الذي تريد التقدم اليه ؟"),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                      title: AppStrings.requestVacation,
                      onPressed: controller.gotoVacationRequest,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                      title: AppStrings.requestDelay,
                      onPressed: controller.gotoDelayRequest,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                      title: AppStrings.requestLeave,
                      onPressed: controller.gotoLeaveRequest,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                      title: "طلب سلفة",
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              "ملاحظة : لم يتم إعتماد اي طلب من دون التوقيع الرسمي المعتمد في الشركة. ",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
