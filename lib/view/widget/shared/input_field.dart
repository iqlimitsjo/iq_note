import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomInputField extends StatelessWidget {
  final String title;
  final String hint;
  final Widget icon;
  final TextEditingController? myController;
  final String? Function(String?) valid;
  final TextInputType? type;
  final bool? obscureText;
  final void Function()? onTapIcon;
  final bool isReadOnly;

  const CustomInputField({
    super.key,
    required this.title,
    required this.hint,
    required this.icon,
    this.myController,
    required this.valid,
    this.type,
    this.obscureText,
    this.onTapIcon,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 25),
      child: TextFormField(
        keyboardType: type,
        maxLines: obscureText == true ? 1 : 5,
        minLines: 1,
        obscureText: obscureText == null || obscureText == false ? false : true,
        validator: valid,
        readOnly: isReadOnly == true ? true : false,
        controller: myController,
        cursorColor: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 16),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 9),
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
            suffixIcon: InkWell(
              onTap: onTapIcon,
              child: icon,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}
