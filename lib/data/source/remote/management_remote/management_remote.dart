import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/class/crud_firebase.dart';
import '../../../../core/class/custom_response.dart';

class ManagementRequestData {
  CRUDFirebase crud;

  ManagementRequestData(this.crud);

  Future<(CustomResponse, String)> addRequest(
      {required String collectionName,
      required Map<String, dynamic> data,
      String? path,
      String? subCollection}) async {
    var response = await CRUDFirebase.addData(
        collectionName: collectionName,
        data: data,
        path: path,
        subCollection: subCollection);
    return response;
  }

  Future<(List<QueryDocumentSnapshot<Object?>>, CustomResponse)> getAllRequest({
    required String collectionName,
    required String orderBy,
    bool? ascending,
  }) async {
    var response = await CRUDFirebase.getData(
        collectionName: collectionName, orderBy: orderBy, ascending: ascending);
    return response;
  }

  Future<(List<QueryDocumentSnapshot<Object?>>, CustomResponse)> getRequest({
    required String collectionName,
    required String orderBy,
    required String condition,
    required String field,
    bool? ascending,
  }) async {
    var response = await CRUDFirebase.getQueryData(
      collectionName: collectionName,
      orderBy: orderBy,
      ascending: ascending,
      field: field,
      condition: condition,
    );
    return response;
  }

  Future<(String, CustomResponse)> uploadFile(
      File file, String childName, String id, String nameId) async {
    var response = await CRUDFirebase.uploadFile(
      file: file,
      childName: childName,
      id: id,
      nameId: nameId,
    );
    return response;
  }

  updateRequest({
    required String collectionName,
    required String id,
    required Map<String, dynamic> data,
    String? subCollectionName,
    String? subCollectionId,
  }) async {
    var response = await CRUDFirebase.updateData(
        collectionName: collectionName,
        data: data,
        docId: id,
        subCollectionId: subCollectionId,
        subCollectionName: subCollectionName);
    return response;
  }
}
