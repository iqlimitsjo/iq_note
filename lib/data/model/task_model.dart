import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final int? taskId;
  final String? taskTitle;
  final String? taskBody;
  final String? taskDate;
  final String? taskStartTime;
  final String? taskEndTime;
  final String? taskPriority;
  final String? taskRepeat;
  final String? taskRemind;
  final String? taskIsCompleted;
  final String? color;
  final String? audioUrl;
  final String? imageUrl;
  final String? id;
  final String? department;
  final Map<String, String?>? attachments;

  TaskModel({
    this.taskId,
    this.taskTitle,
    this.taskBody,
    this.taskDate,
    this.taskStartTime,
    this.taskEndTime,
    this.taskPriority,
    this.taskRepeat,
    this.taskRemind,
    this.taskIsCompleted,
    this.color,
    this.id,
    this.department,
    this.imageUrl,
    this.audioUrl,
    this.attachments,
  });

  Map<String, dynamic> toJson() {
    return {
      "task_id": taskId,
      "id": id,
      "title": taskTitle,
      "body": taskBody,
      "date": taskDate,
      "start_time": taskStartTime,
      "end_time": taskEndTime,
      "priority": taskPriority,
      "repeat": taskRepeat,
      "remind": taskRemind,
      "isCompleted": taskIsCompleted,
      "color": color,
      "department": department,
      "attachments": attachments,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskId: json["task_id"],
      id: json["id"],
      taskTitle: json["title"],
      taskBody: json["body"],
      taskDate: json["date"],
      taskStartTime: json["start_time"],
      taskEndTime: json["end_time"],
      taskPriority: json["priority"],
      taskRepeat: json["repeat"],
      taskRemind: json["remind"],
      taskIsCompleted: json["isCompleted"],
      color: json["color"],
      department: json["department"],
      attachments: json["attachments"],
    );
  }

  factory TaskModel.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return TaskModel(
      taskId: data["task_id"],
      id: data["id"],
      taskTitle: data["title"],
      taskBody: data["body"],
      taskDate: data["date"],
      taskStartTime: data["start_time"],
      taskEndTime: data["end_time"],
      taskPriority: data["priority"],
      taskRepeat: data["repeat"],
      taskRemind: data["remind"],
      taskIsCompleted: data["isCompleted"],
      color: data["color"],
      department: data["department"],
      imageUrl: data["attachments"]['image_url'],
      audioUrl: data["attachments"]['audio_url'],
    );
  }

  @override
  String toString() {
    return '''
      "task Id": $taskId,
      "Id": $id,
      "task Title": $taskTitle,
      "task Body": $taskBody,
      "task Date": $taskDate,
      "task Start Time": $taskStartTime,
      "task End Time": $taskEndTime,
      "task Priority": $taskPriority,
      "task Repeat": $taskRepeat,
      "task Remind": $taskRemind,
      "task Is Completed": $taskIsCompleted,
      "task Color": $color,
      "task department": $department,
      "task image URL": $imageUrl,
      "task audio URL": $audioUrl,
  ''';
  }
}
