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
      },
    );
    return response;
  }

  Future<(List<QueryDocumentSnapshot<Object?>>, CustomResponse)> getTask(
      String collectionName) async {
    var response = await CRUDFirebase.getData(collectionName: collectionName);
    return response;
  }

  Future<(String, CustomResponse)> uploadFile(
      File file, String childName) async {
    var response = await CRUDFirebase.uploadFile(
      file: file,
      childName: childName,
    );
    return response;
  }

  deleteTask(String collectionName, String id) async {
    var response = await CRUDFirebase.deleteData(
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
