import 'package:get/get.dart';

import '../../core/function/send_fcm.dart';
import '../../data/model/task_model.dart';
import '../../data/model/user_model.dart';
import '../../data/source/static/user_data.dart';

class SendNotificationsToUserController extends GetxController {
  late TaskModel task;
  List<UserModel> userList = [];

  sendTaskNotificationToUser({required String topicId}) {
    sendFCM(
      topic: topicId,
      title: task.taskTitle!,
      body: task.taskBody!,
    );
  }

  @override
  void onInit() {
    task = Get.arguments['task'];
    userList.addAll(userDataList.where(
        (element) => element.userDepartment == userDataList[0].userDepartment));
    super.onInit();
  }
}
