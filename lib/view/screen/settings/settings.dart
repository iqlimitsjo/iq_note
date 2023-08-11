import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/settings_controller/settings_controller.dart';
import '../../../core/class/handling_data_view.dart';
import '../../../core/constant/strings.dart';
import '../../widget/settings/setting_tile.dart';
import '../../widget/settings/settings_header.dart';
import '../../widget/shared/app_bar.dart';
import '../../widget/shared/app_drawer.dart';

class UserSettings extends StatelessWidget {
  const UserSettings({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: customAppBar(
        title: AppStrings.settings,
        isHome: false,
      ),
      body: GetBuilder<SettingsController>(
        builder: (controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: ListView(
                children: [
                  const SettingHeader(),
                  const SizedBox(height: 20),
                  if (controller.file != null)
                    Center(
                      child: ElevatedButton(
                        onPressed: controller.saveChange,
                        child: const Text(
                          AppStrings.save,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  if (controller.myServices.supportState)
                    GetBuilder<SettingsController>(builder: (controller) {
                      return SwitchListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        activeColor: Colors.green,
                        title: const Text(AppStrings.enableBiometrics),
                        value: controller.biometricEnabled,
                        onChanged: (value) {
                          controller.toggleBiometric(value);
                        },
                      );
                    }),
                  SettingTile(
                    onTap: () => controller.goToChangeUserName(),
                    title: "تغيير اسم المستخدم",
                    icon: Icons.person_rounded,
                  ),
                  SettingTile(
                    onTap: () => controller.goToChangeEmail(),
                    title: "تغيير البريد الالكتروني",
                    icon: Icons.alternate_email_rounded,
                  ),
                  SettingTile(
                    onTap: () => controller.goToChangePassword(),
                    title: "تغيير الرقم السري",
                    icon: Icons.password_rounded,
                  ),
                  SettingTile(
                    onTap: () => controller.goToChangePhone(),
                    title: "تغيير رقم الهاتف",
                    icon: Icons.phone,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )),
      ),
    );
  }
}
