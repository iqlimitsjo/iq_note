import 'package:get/get.dart';

import '../../core/services/services.dart';

class NotificationController extends GetxController {
  String payload = "";
  MyServices myServices = Get.find();
  @override
  void onInit() {
    payload = Get.arguments['payload'];
    super.onInit();
  }
}
