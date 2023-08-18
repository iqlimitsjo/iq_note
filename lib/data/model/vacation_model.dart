import 'package:cloud_firestore/cloud_firestore.dart';

class VacationModel {
  final String? vacationId;
  final String? userId;
  final String? userName;
  final String? dataRequest;
  final String? vacationStartDate;
  final String? vacationLength;
  final String? requestReason;
  final String? isRead;
  final String? isViewed;
  final String? requestStatus;
  final String? signatureURL;

  VacationModel({
    this.vacationId,
    this.userId,
    this.userName,
    this.dataRequest,
    this.vacationStartDate,
    this.vacationLength,
    this.requestReason,
    this.isRead,
    this.isViewed,
    this.requestStatus,
    this.signatureURL,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": vacationId,
      "user_id": userId,
      "user_name": userName,
      "date_request": dataRequest,
      "vacation_start_date": vacationStartDate,
      "vacation_length": vacationLength,
      "request_reason": requestReason,
      "is_read": isRead,
      "is_viewed": isViewed,
      "request_status": requestStatus,
      "image_url": signatureURL,
    };
  }

  factory VacationModel.fromJson(Map<String, dynamic> json) {
    return VacationModel(
      vacationId: json["id"],
      userId: json["user_id"],
      userName: json["user_name"],
      dataRequest: json["date_request"],
      vacationStartDate: json["vacation_start_date"],
      vacationLength: json["vacation_length"],
      requestReason: json["request_reason"],
      isRead: json["is_read"],
      isViewed: json["is_viewed"],
      requestStatus: json["request_status"],
      signatureURL: json["image_url"],
    );
  }

  factory VacationModel.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return VacationModel(
      vacationId: data["id"],
      userId: data["user_id"],
      userName: data["user_name"],
      dataRequest: data["date_request"],
      vacationStartDate: data["vacation_start_date"],
      vacationLength: data["vacation_length"],
      requestReason: data["request_reason"],
      isRead: data["is_read"],
      isViewed: data["is_viewed"],
      requestStatus: data["request_status"],
      signatureURL: data["image_url"],
    );
  }

  @override
  String toString() {
    return '''
      "id": $vacationId,
      "user_id": $userId,
      "user_name": $userName,
      "date_request": $dataRequest,
      "vacation_start_date": $vacationStartDate,
      "vacation_length": $vacationLength,
      "request_reason": $requestReason,
      "is_read": $isRead,
      "is_viewed": $isViewed,
      "request_status": $requestStatus,
      "image_url": $signatureURL,
  ''';
  }
}
