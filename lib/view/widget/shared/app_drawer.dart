import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/drawer_controller/drawer_controller.dart';
import '../../../core/constant/routes.dart';
import '../../../core/constant/strings.dart';
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
        return ListView(
          children: [
            AppDrawerHeader(
              imageURL: controller.userImage!,
              userName: controller.userName!,
            ),
            DrawerListTile(
              title: AppStrings.home,
              icon: Icons.home,
              onTap: () {
                Get.offAllNamed(AppRoutes.home);
              },
            ),
            DrawerListTile(
              title: AppStrings.addUser,
              icon: Icons.person_2_outlined,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.addUser);
              },
            ),
            DrawerListTile(
              title: AppStrings.settings,
              icon: Icons.settings,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.addUser);
              },
            ),
            DrawerListTile(
              title: AppStrings.signOut,
              icon: Icons.logout,
              onTap: () => controller.signout(),
            ),
          ],
        );
      }),
    );
  }
}
