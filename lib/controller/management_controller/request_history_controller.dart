import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/status_request.dart';
import '../../core/function/handling_data_controller.dart';
import '../../core/services/services.dart';
import '../../data/model/delay_model.dart';
import '../../data/model/leave_model.dart';
import '../../data/model/vacation_model.dart';
import '../../data/source/remote/management_remote/management_remote.dart';

class RequestHistoryController extends GetxController {
  ManagementRequestData managementData = ManagementRequestData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  List<VacationModel> vacationData = [];
  List<LeaveModel> leaveData = [];
  List<DelayModel> delayData = [];
  List orderTabs = [
    {'title': 'الإجازات', 'icon': Icons.holiday_village},
    {'title': 'التأخير', 'icon': Icons.snooze},
    {'title': 'المغادرات', 'icon': Icons.time_to_leave},
    {'title': 'السلف النقدية', 'icon': Icons.attach_money},
  ];

  getRequest(
      {required String requestName,
      required List<dynamic> data,
      dynamic value}) async {
    data.clear();

    statusRequest = StatusRequest.loading;
    update();

    var response = await managementData.getAllRequest(
        collectionName: "management_request",
        subDocument: myServices.user.uid,
        subCollection: requestName,
        orderBy: "date_request");

    statusRequest = handlingFirebaseData(response.$2);
    if (statusRequest == StatusRequest.success &&
        response.$2.message == "success") {
      for (var element in response.$1) {
        data.add(value(element));
      }
      print(data.toString());
      statusRequest = StatusRequest.success;
    }

    print(response.$2.message);

    update();
  }

  @override
  void onInit() {
    getRequest(
      requestName: 'vacation',
      data: vacationData,
      value: VacationModel.fromFirestore,
    );
    getRequest(
      requestName: 'leave',
      data: leaveData,
      value: LeaveModel.fromFirestore,
    );
    getRequest(
      requestName: 'delay',
      data: delayData,
      value: DelayModel.fromFirestore,
    );
    super.onInit();
  }
}
