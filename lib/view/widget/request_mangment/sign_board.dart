import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../../../controller/management_controller/request_controller.dart';

class SignBoard extends StatelessWidget {
  const SignBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestController>(builder: (controller) {
      return Stack(
        children: [
          SizedBox(
            height: 180,
            width: double.infinity,
            child: SfSignaturePad(
              key: controller.signaturePadKey,
              minimumStrokeWidth: 2,
              maximumStrokeWidth: 4,
              strokeColor: Colors.green,
              backgroundColor: Colors.grey[350],
            ),
          ),
          IconButton(
            key: const Key('clear'),
            icon: const Icon(Icons.clear),
            color: Colors.blue,
            onPressed: controller.clearSign,
            tooltip: 'Clear',
          ),
        ],
      );
    });
  }
}
