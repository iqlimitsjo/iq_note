import 'package:get/get.dart';

import '../../core/constant/routes.dart';
import '../../core/services/services.dart';
import '../../data/source/static/user_data.dart';

class CustomDrawerController extends GetxController {
  MyServices myServices = Get.find();
  String? userImage;
  String? userName;

  signout() async {
    await myServices.firebaseAuth.signOut();
    userDataList.clear();
    allUsers.clear();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onInit() {
    userImage = myServices.user.photoURL;
    userName = myServices.user.displayName;
    print(userName);

    super.onInit();
  }
}
