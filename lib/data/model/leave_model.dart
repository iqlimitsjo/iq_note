import 'package:cloud_firestore/cloud_firestore.dart';

class LeaveModel {
  final String? leaveId;
  final String? userId;
  final String? userName;
  final String? dataRequest;
  final String? leaveStartDate;
  final String? leaveStart;
  final String? leaveEnd;
  final String? requestReason;
  final String? isRead;
  final String? isViewed;
  final String? requestStatus;
  final String? signatureURL;

  LeaveModel({
    this.leaveId,
    this.userId,
    this.userName,
    this.dataRequest,
    this.leaveStartDate,
    this.leaveStart,
    this.leaveEnd,
    this.requestReason,
    this.isRead,
    this.isViewed,
    this.requestStatus,
    this.signatureURL,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": leaveId,
      "user_id": userId,
      "user_name": userName,
      "date_request": dataRequest,
      "leave_start_date": leaveStartDate,
      "leave_start": leaveStart,
      "leave_end": leaveEnd,
      "request_reason": requestReason,
      "is_read": isRead,
      "is_viewed": isViewed,
      "request_status": requestStatus,
      "image_url": signatureURL,
    };
  }

  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      leaveId: json["id"],
      userId: json["user_id"],
      userName: json["user_name"],
      dataRequest: json["date_request"],
      leaveStartDate: json["leave_start_date"],
      leaveStart: json["leave_start"],
      leaveEnd: json["leave_end"],
      requestReason: json["request_reason"],
      isRead: json["is_read"],
      isViewed: json["is_viewed"],
      requestStatus: json["request_status"],
      signatureURL: json["image_url"],
    );
  }

  factory LeaveModel.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return LeaveModel(
      leaveId: data["id"],
      userId: data["user_id"],
      userName: data["user_name"],
      dataRequest: data["date_request"],
      leaveStartDate: data["leave_start_date"],
      leaveStart: data["leave_start"],
      leaveEnd: data["leave_end"],
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
      "id": $leaveId,
      "user_id": $userId,
      "user_name": $userName,
      "date_request": $dataRequest,
      "leave_start_date": $leaveStartDate,
      "leave_start": $leaveStart,
      "leave_end": $leaveEnd,
      "request_reason": $requestReason,
      "is_read": $isRead,
      "is_viewed": $isViewed,
      "request_status": $requestStatus,
      "image_url": $signatureURL,
  ''';
  }
}
