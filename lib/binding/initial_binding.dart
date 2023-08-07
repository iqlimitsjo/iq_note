import 'package:get/get.dart';

import '../core/class/crud_firebase.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CRUDFirebase());
  }
}
