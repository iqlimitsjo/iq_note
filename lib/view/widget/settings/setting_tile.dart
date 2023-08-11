import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;

  const SettingTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1, color: Get.isDarkMode ? Colors.white : Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(title),
        leading: Icon(icon),
        trailing: const Icon(Icons.arrow_forward_ios_outlined),
      ),
    );
  }
}
