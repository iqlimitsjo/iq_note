import 'package:flutter/material.dart';

class NoBorderInputField extends StatelessWidget {
  final TextEditingController? textController;

  // final String? Function(String?) valid;
  final bool isReadOnly;
  final bool isEnabled;

  const NoBorderInputField({
    super.key,
    this.textController,
    // required this.valid,
    required this.isReadOnly,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      readOnly: isReadOnly,
      minLines: 1,
      maxLines: 10,
      controller: textController,
      style: const TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        // contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        border: InputBorder.none,
      ),
    );
  }
}
