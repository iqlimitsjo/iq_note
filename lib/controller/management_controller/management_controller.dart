import 'package:get/get.dart';

import '../../core/constant/routes.dart';
import '../../core/services/services.dart';

class ManagementController extends GetxController {
  MyServices myServices = Get.find();
  late String name;

  gotoVacationRequest() {
    Get.toNamed(AppRoutes.requestVacation, arguments: {'from': 'vacation'});
  }

  gotoDelayRequest() {
    Get.toNamed(AppRoutes.requestVacation, arguments: {'from': 'delay'});
  }

  gotoLeaveRequest() {
    Get.toNamed(AppRoutes.requestVacation, arguments: {'from': 'leave'});
  }

  gotoLoan() {
    Get.toNamed(AppRoutes.requestVacation);
  }

  @override
  void onInit() {
    name = myServices.user.displayName!;
    super.onInit();
  }
}
