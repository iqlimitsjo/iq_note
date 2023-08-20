import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/management_controller/request_history_controller.dart';
import '../../../core/class/handling_data_view.dart';

class TabRequest extends GetView<RequestHistoryController> {
  final List<dynamic> data;

  const TabRequest({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: HandlingDataView(
        statusRequest: controller.statusRequest,
        widget: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => ListTile(
                  title:
                      Text(controller.delayData[index].requestReason ?? "kkk"),
                )

            //     OrdersCard(
            //   ordersModel: data[index],
            // ),
            ),
      ),
    );
  }
}
