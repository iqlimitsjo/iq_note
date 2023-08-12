import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:record/record.dart';

import '../../core/class/status_request.dart';
import '../../core/constant/routes.dart';
import '../../core/constant/strings.dart';
import '../../core/function/handling_data_controller.dart';
import '../../core/function/show_snackbar.dart';
import '../../core/services/services.dart';
import '../../data/model/task_model.dart';
import '../../data/source/remote/task_remote/task_remote.dart';
import '../../data/source/static/user_data.dart';
import '../home_controller/home_controller.dart';

class AddTaskController extends GetxController {
  Record audioRecord = Record();
  AudioPlayer audioPlayer = AudioPlayer();
  bool isRecording = false;
  String? audioPath;
  PlayerState playerState = PlayerState.stopped;
  Duration currentDuration = Duration.zero;
  File? file;
  File? audioFile;

  String? downloadUrl;
  String? audioDownloadUrl;
  MyServices myServices = Get.find();
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TaskData taskData = TaskData(Get.find());
  HomeController homeController = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequestMedia = StatusRequest.none;
  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  String selectedRemind = "5";
  String selectedRepeat = '0';
  String selectedPriority = '3';
  String selectedColor = "5";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? selectedImage;

  updateSelectedDate(DateTime? dateTime) {
    selectedDate = dateTime ?? DateTime.now();
    update();
  }

  updateStartTime(String? dateTime) {
    startTime = dateTime!;
    update();
  }

  updateEndTime(String? dateTime) {
    endTime = dateTime!;
    update();
  }

  getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15))),
      helpText: "إختر الوقت",
      confirmText: AppStrings.ok,
      cancelText: AppStrings.cancel,
    );
    String formattedDate = pickedTime!.format(Get.context!);

    if (isStartTime) {
      startTime = formattedDate;
    } else {
      endTime = formattedDate;
    }

    update();
  }

  adTask() async {
    if (formKey.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      // await uploadImage();
      // await uploadRecord();

      var data = TaskModel(
          taskId: Random().nextInt(10000),
          taskTitle: titleController.text.trim(),
          taskBody: noteController.text.trim(),
          taskDate: DateFormat.yMd().format(selectedDate),
          taskStartTime: startTime,
          taskEndTime: endTime,
          taskPriority: selectedPriority,
          taskRepeat: selectedRepeat,
          taskRemind: selectedRemind,
          taskIsCompleted: "0",
          color: selectedColor.toString(),
          department: userDataList[0].userDepartment,
          attachments: {
            'audio_url': audioDownloadUrl,
            'image_url': downloadUrl
          });

      var response = await taskData.addTask("limits", data);

      statusRequest = handlingFirebaseData(response.$1);
      await uploadAttachment(
          collectionName: 'Images', id: response.$2, file: file);
      await uploadAttachment(
          collectionName: 'Voice', id: response.$2, file: audioFile);
      await taskData.updateTask(
        "limits",
        response.$2,
        {
          'attachments': {
            'audio_url': audioDownloadUrl,
            'image_url': downloadUrl
          }
        },
      );

      if (StatusRequest.success == statusRequest) {
        showSnackBar(
            "تمت العملية", "تم إضافة الملاحظة بنجاح", Icons.done_rounded);

        homeController.getTask();
        Get.offAndToNamed(AppRoutes.home);
      }
      update();
    }
  }

  startRecord() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start(encoder: AudioEncoder.wav);
        isRecording = await audioRecord.isRecording();
        audioPath = "";
        update();
      }
    } catch (e) {
      print("start recording Error: $e");
    }
  }

  deleteRecord() async {
    audioPath = null;
    audioRecord.dispose();
    currentDuration = Duration.zero;

    update();
  }

  stopRecording() async {
    try {
      String? path = await audioRecord.stop();
      isRecording = await audioRecord.isRecording();
      audioPath = path!;
      audioFile = File(audioPath!);
      print(path);

      update();
    } catch (e) {
      print("stop recording Error: $e");
    }
  }

  playRecording() async {
    try {
      Source urlSource = UrlSource(audioPath!);
      update();
      audioPlayer.onPositionChanged.listen((event) {
        currentDuration = event;
        update();
      });
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

  selectImage(ImageSource imageSource) async {
    XFile? xFile = await ImagePicker().pickImage(source: imageSource);
    if (xFile?.path == null) {
      showSnackBar(
        AppStrings.error,
        "لم تقم بإختيار صورة",
        Icons.info_outline,
      );
    } else {
      file = File(xFile!.path);
      selectedImage = xFile.path.split(".")[2].split("-")[4].toString();
    }
    update();
  }

  deleteImage() {
    file!.delete();
    selectedImage = null;
    update();
  }

  uploadAttachment({
    required String collectionName,
    required String id,
    required File? file,
  }) async {
    if (file != null) {
      var response = await taskData.uploadFile(
        file,
        collectionName,
        id,
      );
      if (response.$2.message == "success") {
        collectionName == "Voice"
            ? audioDownloadUrl = response.$1
            : downloadUrl = response.$1;
      } else {
        statusRequest = StatusRequest.failed;
      }
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    audioPlayer.dispose();
    audioRecord.dispose();
    super.dispose();
  }
}
