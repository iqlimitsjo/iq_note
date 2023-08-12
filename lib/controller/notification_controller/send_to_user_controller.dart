import 'package:get/get.dart';

import '../../core/function/send_fcm.dart';
import '../../data/model/task_model.dart';

class SendNotificationsToUserController extends GetxController {
  late TaskModel task;

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
    super.onInit();
  }
}
