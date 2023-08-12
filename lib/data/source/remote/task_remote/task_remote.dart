import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/class/crud_firebase.dart';
import '../../../../core/class/custom_response.dart';
import '../../../model/task_model.dart';

class TaskData {
  CRUDFirebase crud;

  TaskData(this.crud);

  Future<(CustomResponse, String)> addTask(
      String collectionName, TaskModel task) async {
    var response = await CRUDFirebase.addData(
      collectionName: collectionName,
      data: {
        "task_id": task.taskId,
        "title": task.taskTitle,
        "body": task.taskBody,
        "date": task.taskDate,
        "start_time": task.taskStartTime,
        "end_time": task.taskEndTime,
        "priority": task.taskPriority,
        "repeat": task.taskRepeat,
        "remind": task.taskRemind,
        "isCompleted": task.taskIsCompleted,
        "color": task.color,
        "department": task.department,
        "attachments": task.attachments,
      },
    );
    return response;
  }

  Future<(List<QueryDocumentSnapshot<Object?>>, CustomResponse)> getAllTask({
    required String collectionName,
    required String orderBy,
    bool? ascending,
  }) async {
    var response = await CRUDFirebase.getData(
        collectionName: collectionName, orderBy: orderBy, ascending: ascending);
    return response;
  }

  Future<(List<QueryDocumentSnapshot<Object?>>, CustomResponse)> getTask({
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
      File file, String childName, String id) async {
    var response = await CRUDFirebase.uploadFile(
      file: file,
      childName: childName,
      id: id,
      nameId: id,
    );
    return response;
  }

  deleteTask(String collectionName, String id) async {
    var response = await CRUDFirebase.deleteData(
        collectionName: collectionName, docId: id);
    return response;
  }

  deleteFile(String collectionName, String id) async {
    var response = await CRUDFirebase.deleteFile(
        collectionName: collectionName, docId: id);
    return response;
  }

  updateTask(
      String collectionName, String id, Map<String, dynamic> data) async {
    var response = await CRUDFirebase.updateData(
        collectionName: collectionName, data: data, docId: id);
    return response;
  }
}
