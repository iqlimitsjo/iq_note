import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/color.dart';

class DrawerListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;

  const DrawerListTile(
      {super.key, required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Text(
          title.tr,
          style: const TextStyle(fontSize: 20),
        ),
        leading: Icon(
          icon,
          size: 30,
          color: AppColor.primaryClr,
        ),
      ),
    );
  }
}
