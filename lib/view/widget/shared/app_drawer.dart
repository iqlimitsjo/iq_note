import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/drawer_controller/drawer_controller.dart';
import '../../../core/constant/routes.dart';
import '../../../core/constant/strings.dart';
import '../../../data/source/static/static_department_list.dart';
import '../../../data/source/static/user_data.dart';
import '../drawer/drawer_listtile.dart';
import '../drawer/header_drawer.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CustomDrawerController());
    return Drawer(
      elevation: 10,
      child: GetBuilder<CustomDrawerController>(builder: (controller) {
        return Column(
          children: [
            AppDrawerHeader(
              imageURL: controller.userImage ?? "",
              userName: controller.userName!,
            ),
            DrawerListTile(
              title: AppStrings.home,
              icon: Icons.home,
              onTap: () {
                Get.offAllNamed(AppRoutes.home);
              },
            ),
            if (userDataList[0].userLevel == "2")
              DrawerListTile(
                title: AppStrings.addUser,
                icon: Icons.person_2_outlined,
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.addUser);
                },
              ),
            DrawerListTile(
              title: AppStrings.managementServices,
              icon: Icons.edit_document,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.managementServicesMain);
              },
            ),
            DrawerListTile(
              title: AppStrings.historyRequest,
              icon: Icons.history,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.requestHistory);
              },
            ),
            DrawerListTile(
              title: AppStrings.managementRequests,
              icon: Icons.request_page,
              onTap: () {
                Get.back();
                // Get.toNamed(AppRoutes.settings);
              },
            ),
            DrawerListTile(
              title: AppStrings.settings,
              icon: Icons.settings,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.settings);
              },
            ),
            DrawerListTile(
              title: AppStrings.signOut,
              icon: Icons.logout,
              onTap: () => controller.signout(),
            ),
            const Spacer(),
            const Divider(
              color: Colors.grey,
              thickness: 1.5,
              endIndent: 15,
              indent: 15,
            ),
            Text(
              "قسم : ${departmentList[int.parse(userDataList[0].userDepartment!)].title}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10)
          ],
        );
      }),
    );
  }
}
