import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/class/crud_firebase.dart';
import '../../../../core/class/custom_response.dart';
import '../../../model/user_model.dart';

class UserData {
  CRUDFirebase crud;

  UserData(this.crud);

  addUser(String collectionName, UserModel user, String path) async {
    var response = await CRUDFirebase.addData(
        collectionName: collectionName,
        data: {
          "id": path,
          "user_name": user.userName,
          "user_email": user.userEmail,
          "user_phone": user.userPhone,
          "user_level": user.userLevel,
          "user_department": user.userDepartment,
          "user_images": user.userImage,
        },
        path: path);
    return response;
  }

  Future<(List<QueryDocumentSnapshot<Object?>>, CustomResponse)> getUserData(
      String collectionName) async {
    var response = await CRUDFirebase.getData(collectionName: collectionName);
    return response;
  }

  Future<(String, CustomResponse)> uploadFile(File file) async {
    var response =
        await CRUDFirebase.uploadFile(file: file, childName: "users");
    return response;
  }

// deleteTask(String collectionName, String id) async {
//   var response = await CRUDFirebase.deleteData(
//       collectionName: collectionName, docId: id);
//   return response;
// }

  updateUser(
      String collectionName, String id, Map<String, dynamic> data) async {
    var response = await CRUDFirebase.updateData(
        collectionName: collectionName, data: data, docId: id);
    return response;
  }
}
