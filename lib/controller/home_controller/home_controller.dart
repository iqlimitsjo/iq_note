import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../core/class/status_request.dart';
import '../../core/constant/routes.dart';
import '../../core/constant/strings.dart';
import '../../core/function/handling_data_controller.dart';
import '../../core/function/show_snackbar.dart';
import '../../core/services/notification_services.dart';
import '../../core/services/services.dart';
import '../../data/model/task_model.dart';
import '../../data/source/remote/task_remote/task_remote.dart';
import '../../data/source/static/user_data.dart';

class HomeController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  DateTime selectedDate = DateTime.now();
  TaskData taskData = TaskData(Get.find());
  List<TaskModel> data = [];
  bool isEditing = false;
  late NotifyHelper notifiHelper;
  TextEditingController noteTitle = TextEditingController();
  TextEditingController noteBody = TextEditingController();

  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState playerState = PlayerState.stopped;
  Duration currentDuration = Duration.zero;

  goToSelectedFilter() async {
    DateTime? dataPicker = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2035),
      helpText: "إختر التاريخ",
      confirmText: AppStrings.ok,
      cancelText: AppStrings.cancel,
    );
    if (dataPicker != null) {
      Get.toNamed(AppRoutes.filteredTask, arguments: {
        'selectedDate': DateFormat.yMd().format(dataPicker).toString(),
        "task": data.where((element) =>
            DateFormat.yMd().parse(element.taskDate!) == dataPicker)
      });
    }
  }

  getTask() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response;
    if (userDataList[0].userLevel == "2") {
      response = await taskData.getAllTask(
        collectionName: "limits",
        orderBy: "priority",
      );
    } else {
      response = await taskData.getTask(
        collectionName: "limits",
        orderBy: "priority",
        field: 'department',
        condition: userDataList[0].userDepartment!,
      );
    }

    statusRequest = handlingFirebaseData(response.$2);
    if (statusRequest == StatusRequest.success &&
        response.$2.message == "success") {
      for (var element in response.$1) {
        data.add(TaskModel.fromFirestore(element));
      }
      print(data.toString());
      statusRequest = StatusRequest.success;
    }

    print(response.$2.message);

    update();
  }

  deleteTask(String id) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await taskData.deleteTask('limits', id);
    statusRequest = handlingFirebaseData(response);
    if (statusRequest == StatusRequest.success) {
      await showSnackBar(
          "تم بنجاح", "تم حذف الملاحظة بنجاح", Icons.delete_forever);

      getTask();
      update();
    }
    update();
  }

  updateTask(String id, String value) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await taskData.updateTask('limits', id, {
      'isCompleted': value,
    });
    statusRequest = handlingFirebaseData(response);
    if (statusRequest == StatusRequest.success) {
      await showSnackBar("تم بنجاح", "تم تعديل الملاحظة بنجاح", Icons.edit);

      getTask();
      update();
    }
    update();
  }

  delayTask(String id, String value) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await taskData.updateTask('limits', id, {
      'date': value,
    });
    statusRequest = handlingFirebaseData(response);
    if (statusRequest == StatusRequest.success) {
      await showSnackBar("تم بنجاح", "تم تعديل الملاحظة بنجاح", Icons.edit);

      getTask();
      update();
    }
    update();
  }

  updateSelectedDate(DateTime? dateTime) {
    selectedDate = dateTime ?? DateTime.now();
    update();
  }

  playRecording(String audioPath) async {
    try {
      Source urlSource = UrlSource(audioPath);
      // update();
      // audioPlayer.onPositionChanged.listen((event) {
      //   currentDuration = event;
      //   update();
      // });
      await audioPlayer.play(urlSource);
      audioPlayer.onPlayerComplete.listen((event) {
        playerState = PlayerState.completed;
        update();
      });

      audioPlayer.onPlayerStateChanged
          .listen((PlayerState s) => playerState = s);

      update();
    } catch (e) {
      print("play recording Error: $e");
    }
  }

  stopPlayRecording() async {
    await audioPlayer.stop();
    update();
  }

  pausePlayRecording() async {
    await audioPlayer.pause();
    update();
  }

  goToEditTask(TaskModel editTask) {
    Get.toNamed(AppRoutes.editTask, arguments: {
      'task': editTask,
    });
  }

  @override
  void onInit() {
    initializeDateFormatting();
    notifiHelper = NotifyHelper();
    notifiHelper.requestIOSPermissions();
    notifiHelper.initializeNotification();
    getTask();
    super.onInit();
  }
}
