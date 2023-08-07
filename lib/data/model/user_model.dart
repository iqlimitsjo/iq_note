import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? userId;
  final String? userName;
  final String? userEmail;
  final String? userPhone;
  final String? userLevel;
  final String? userDepartment;
  final String? userImage;

  UserModel({
    this.userId,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.userLevel,
    this.userDepartment,
    this.userImage,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": userId,
      "user_name": userName,
      "user_email": userEmail,
      "user_phone": userPhone,
      "user_level": userLevel,
      "user_department": userDepartment,
      "user_images": userImage,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["id"],
      userName: json["user_name"],
      userEmail: json["user_email"],
      userPhone: json["user_phone"],
      userLevel: json["user_level"],
      userDepartment: json["user_department"],
      userImage: json["user_images"],
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      userId: data["id"],
      userName: data["user_name"],
      userEmail: data["user_email"],
      userPhone: data["user_phone"],
      userLevel: data["user_level"],
      userDepartment: data["user_department"],
      userImage: data["user_images"],
    );
  }

  @override
  String toString() {
    return '''
      "Id": $userId,
      "userName": $userName,
      "user Email": $userEmail,
      "user Phone": $userPhone,
      "user Level": $userLevel,
      "user Department": $userDepartment,
      "user Images": $userImage,
  ''';
  }
}
