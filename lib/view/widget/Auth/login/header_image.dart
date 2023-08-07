import 'package:flutter/material.dart';

import '../../../../core/constant/strings.dart';
import '../../../../generated/assets.dart';

class ImageHeader extends StatelessWidget {
  const ImageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 70),
          child: Center(
            child: Image.asset(
              Assets.imagesIqNote,
              height: 150,
              width: 150,
            ),
          ),
        ),
        const Text("مذكرة IQ",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        const Text("إحدى تطبيقات شركة IQ Limits "),
        const SizedBox(height: 20),
        const Center(
          child: Text(
            AppStrings.login,
            style: TextStyle(fontSize: 25, color: Colors.green),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
