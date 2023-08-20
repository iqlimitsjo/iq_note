import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/management_controller/request_history_controller.dart';
import '../../widget/history_request/history_request_tab.dart';
import '../../widget/history_request/tab_request.dart';

class RequestHistory extends StatelessWidget {
  const RequestHistory({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RequestHistoryController());
    return GetBuilder<RequestHistoryController>(
        builder: (controller) => DefaultTabController(
              length: controller.orderTabs.length,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("الطلبات السابقة"),
                  centerTitle: true,
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: [
                      ...List.generate(
                          controller.orderTabs.length,
                          (index) => RequestTabStatus(
                                icon: controller.orderTabs[index]['icon'],
                                title: controller.orderTabs[index]['title'],
                              )),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    TabRequest(data: controller.vacationData),
                    TabRequest(data: controller.delayData),
                    TabRequest(data: controller.leaveData),
                    TabRequest(data: controller.leaveData),
                  ],
                ),
              ),
            ));
  }
}
