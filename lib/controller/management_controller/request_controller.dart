import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../../core/class/status_request.dart';
import '../../core/constant/routes.dart';
import '../../core/constant/strings.dart';
import '../../core/function/custom_dialog.dart';
import '../../core/function/handling_data_controller.dart';
import '../../core/function/send_fcm.dart';
import '../../core/function/show_snackbar.dart';
import '../../core/services/services.dart';
import '../../data/model/delay_model.dart';
import '../../data/model/leave_model.dart';
import '../../data/model/vacation_model.dart';
import '../../data/source/remote/management_remote/management_remote.dart';

class RequestController extends GetxController {
  late String from;
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  ManagementRequestData requestData = ManagementRequestData(Get.find());
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  String vacationLength = "1";
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  bool ageHasError = false;
  File? file;
  bool isFromDelay = false;
  bool isFromVacation = false;
  bool isFromLeave = false;
  String? downloadUrl;
  String collectionName = "";
  GlobalKey<SfSignaturePadState> signaturePadKey = GlobalKey();

  getTitle() {
    switch (from) {
      case 'delay':
        isFromDelay = true;
        collectionName = "delay";
        return AppStrings.requestDelay;
      case 'vacation':
        collectionName = "vacation";
        isFromVacation = true;
        return AppStrings.requestVacation;
      case 'leave':
        collectionName = "leave";
        isFromLeave = true;
        return AppStrings.requestLeave;
    }
    update();
  }

  void onChanged(dynamic val) {
    vacationLength = val.toString();
    print(vacationLength);
    update();
  }

  clearSign() {
    signaturePadKey.currentState?.clear();
    update();
  }

  uploadAttachment({
    required String collectionName,
    required String id,
    required File? file,
    required String fileName,
  }) async {
    if (file != null) {
      var response =
          await requestData.uploadFile(file, collectionName, id, fileName);
      if (response.$2.message == "success") {
        downloadUrl = response.$1;
      } else {
        statusRequest = StatusRequest.failed;
        update();
      }
    }
  }

  saveImage() async {
    final data = await signaturePadKey.currentState!.toImage(pixelRatio: 3.0);
    final imageByteData = await data.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8List = imageByteData!.buffer.asUint8List();

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.path}/image.png';

    file = File(filePath);
    file?.writeAsBytesSync(uint8List);
    await file?.writeAsBytes(uint8List);
    print('Image saved to: $filePath');
    update();
  }

  sendRequest() async {
    if (formKey.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      await saveImage();
      Map<String, dynamic> data = isFromVacation
          ? VacationModel(
              userId: myServices.user.uid,
              userName: myServices.user.displayName,
              dataRequest:
                  DateFormat('dd/MM/yyyy | h:mm a').format(DateTime.now()),
              vacationStartDate: dateController.text.trim(),
              vacationLength: vacationLength.split(".").first,
              requestReason: reasonController.text.trim(),
              isRead: "0",
              isViewed: "0",
              requestStatus: "0",
            ).toJson()
          // {
          //         'user_id': myServices.user.uid,
          //         'user_name': myServices.user.displayName,
          //         'date_request':
          //             DateFormat('dd/MM/yyyy | h:mm a').format(DateTime.now()),
          //         'vacation_start_date': dateController.text.trim(),
          //         'vacation_length': vacationLength.split(".").first,
          //         'request_reason': reasonController.text.trim(),
          //         'is_read': "0",
          //         'is_viewed': "0",
          //         'request_status': '0'
          //       }
          : isFromDelay
              ? DelayModel(
                  userId: myServices.user.uid,
                  userName: myServices.user.displayName,
                  dataRequest:
                      DateFormat('dd/MM/yyyy | h:mm a').format(DateTime.now()),
                  delayStartDate: dateController.text.trim(),
                  delayStart: startTimeController.text,
                  delayEnd: endTimeController.text,
                  requestReason: reasonController.text.trim(),
                  isRead: "0",
                  isViewed: "0",
                  requestStatus: "0",
                ).toJson()
              // {
              //             'user_id': myServices.user.uid,
              //             'user_name': myServices.user.displayName,
              //             'date_request':
              //                 DateFormat('dd/MM/yyyy | h:mm a').format(DateTime.now()),
              //             'delay_start_date': dateController.text.trim(),
              //             'delay_start': startTimeController.text,
              //             'delay_end': endTimeController.text,
              //             'request_reason': reasonController.text.trim(),
              //             'is_read': "0",
              //             'is_viewed': "0",
              //             'request_status': '0',
              //           }
              : LeaveModel(
                  userId: myServices.user.uid,
                  userName: myServices.user.displayName,
                  dataRequest:
                      DateFormat('dd/MM/yyyy | h:mm a').format(DateTime.now()),
                  leaveStartDate: dateController.text.trim(),
                  leaveStart: startTimeController.text,
                  leaveEnd: endTimeController.text,
                  requestReason: reasonController.text.trim(),
                  isRead: "0",
                  isViewed: "0",
                  requestStatus: "0",
                ).toJson();
      //
      // {
      //             'user_id': myServices.user.uid,
      //             'user_name': myServices.user.displayName,
      //             'date_request':
      //                 DateFormat('dd/MM/yyyy | h:mm a').format(DateTime.now()),
      //             'leave_start_date': dateController.text.trim(),
      //             'leave_start': startTimeController.text,
      //             'leave_end': endTimeController.text,
      //             'request_reason': reasonController.text.trim(),
      //             'is_read': "0",
      //             'is_viewed': "0",
      //             'request_status': '0',
      //           };
      var response = await requestData.addRequest(
        collectionName: "management_request",
        path: myServices.user.uid,
        subCollection: collectionName,
        data: data,
      );
      statusRequest = handlingFirebaseData(response.$1);

      await uploadAttachment(
        collectionName: 'Management_request',
        id: myServices.user.uid,
        file: file,
        fileName: response.$2,
      );

      await requestData.updateRequest(
          collectionName: "management_request",
          id: myServices.user.uid,
          data: {
            'image_url': downloadUrl,
          },
          subCollectionName: collectionName,
          subCollectionId: response.$2);

      if (StatusRequest.success == statusRequest) {
        showSnackBar("تمت العملية", "تم إرسال الطلب بنجاح", Icons.done_rounded);

        //  sendNotifications();

        Get.offAndToNamed(AppRoutes.home);
      }
    } else {
      statusRequest = StatusRequest.failed;
      update();
      customDialog(
          context: Get.context!,
          dialogType: DialogType.warning,
          title: "خطأ",
          description: "الرجاء تعبئة كافة الحقول");
    }
  }

  sendNotifications() async {
    await sendFCM(
      topic: "Nmzpyyf8UWS6O5sAIHafhqgHApz1",
      body: "هنالك طلب جديد من ${myServices.user.displayName} ",
      title: "طلب إداري",
      pageId: "management_request",
      pageName: 'management_request',
    );
  }

  @override
  void onInit() {
    from = Get.arguments['from'];
    super.onInit();
  }
}
