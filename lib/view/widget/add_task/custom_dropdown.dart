import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String title;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?) onChanged;

  const CustomDropdownField(
      {super.key,
      required this.title,
      required this.items,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        iconSize: 30,
        enableFeedback: true,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            // borderSide: BorderSide(color: AppColor.primaryClr)
          ),
        ),
        hint: Text(title),
        items: items,
        onChanged: onChanged);
  }
}
