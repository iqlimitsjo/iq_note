import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home_controller/home_controller.dart';
import '../../../core/constant/strings.dart';
import '../../widget/home/add_date_bar.dart';
import '../../widget/home/add_task_bar.dart';
import '../../widget/home/task_view.dart';
import '../../widget/shared/app_bar.dart';
import '../../widget/shared/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      appBar: customAppBar(
          title: AppStrings.home,
          isHome: true,
          onPressed: () => controller.getTask(),
          onSelectDatePressed: () => controller.goToSelectedFilter()),
      body: Column(
        children: [
          const AddTaskBar(),
          const AddDateBar(),
          const SizedBox(height: 20),
          Container(
            child: Row(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: const Text(
                      AppStrings.title,
                      style: TextStyle(fontSize: 20),
                    )),
                const Spacer(),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: const Text(
                      AppStrings.noteCompleted,
                      style: TextStyle(fontSize: 20),
                    )),
              ],
            ),
          ),
          GetBuilder<HomeController>(builder: (controller) {
            return const TaskView();
          }),
        ],
      ),
      drawer: const AppDrawer(),
    );
  }
}
