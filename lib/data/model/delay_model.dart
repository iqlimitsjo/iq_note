import 'package:cloud_firestore/cloud_firestore.dart';

class DelayModel {
  final String? delayId;
  final String? userId;
  final String? userName;
  final String? dataRequest;
  final String? delayStartDate;
  final String? delayStart;
  final String? delayEnd;
  final String? requestReason;
  final String? isRead;
  final String? isViewed;
  final String? requestStatus;
  final String? signatureURL;

  DelayModel({
    this.delayId,
    this.userId,
    this.userName,
    this.dataRequest,
    this.delayStartDate,
    this.delayStart,
    this.delayEnd,
    this.requestReason,
    this.isRead,
    this.isViewed,
    this.requestStatus,
    this.signatureURL,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": delayId,
      "user_id": userId,
      "user_name": userName,
      "date_request": dataRequest,
      "delay_start_date": delayStartDate,
      "delay_start": delayStart,
      "delay_end": delayEnd,
      "request_reason": requestReason,
      "is_read": isRead,
      "is_viewed": isViewed,
      "request_status": requestStatus,
      "image_url": signatureURL,
    };
  }

  factory DelayModel.fromJson(Map<String, dynamic> json) {
    return DelayModel(
      delayId: json["id"],
      userId: json["user_id"],
      userName: json["user_name"],
      dataRequest: json["date_request"],
      delayStartDate: json["delay_start_date"],
      delayStart: json["delay_start"],
      delayEnd: json["delay_end"],
      requestReason: json["request_reason"],
      isRead: json["is_read"],
      isViewed: json["is_viewed"],
      requestStatus: json["request_status"],
      signatureURL: json["image_url"],
    );
  }

  factory DelayModel.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return DelayModel(
      delayId: data["id"],
      userId: data["user_id"],
      userName: data["user_name"],
      dataRequest: data["date_request"],
      delayStartDate: data["delay_start_date"],
      delayStart: data["delay_start"],
      delayEnd: data["delay_end"],
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
      "id": $delayId,
      "user_id": $userId,
      "user_name": $userName,
      "date_request": $dataRequest,
      "delay_start_date": $delayStartDate,
      "delay_start": $delayStart,
      "delay_end": $delayEnd,
      "request_reason": $requestReason,
      "is_read": $isRead,
      "is_viewed": $isViewed,
      "request_status": $requestStatus,
      "image_url": $signatureURL,
  ''';
  }
}
