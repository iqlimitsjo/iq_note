import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';

class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  final Color? color;
  final IconData? icon;
  final bool? maxWidth;

  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.color,
      this.maxWidth,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: maxWidth == true ? double.infinity : null,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        onPressed: onPressed,
        color: color ?? AppColor.primaryClr,
        textColor: Colors.white,
        child: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
