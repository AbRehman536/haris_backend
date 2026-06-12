// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

class TaskModel {
  final String? docId;
  final String? priorityID;
  final String? title;
  final List<dynamic>? favorite;
  final String? description;
  final bool? isCompleted;
  final int? createdAt;

  TaskModel({
    this.docId,
    this.priorityID,
    this.title,
    this.favorite,
    this.description,
    this.isCompleted,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    docId: json["docID"],
    priorityID: json["priorityID"],
    title: json["title"],
    description: json["description"],
    isCompleted: json["isCompleted"],
    favorite: json["favorite"] == null ? [] : List<dynamic>.from(json["favorite"]!.map((x) => x)),
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String taskID) => {
    "docID": taskID,
    "priorityID": priorityID,
    "title": title,
    "description": description,
    "isCompleted": isCompleted,
    "favorite": favorite == null ? [] : List<dynamic>.from(favorite!.map((x) => x)),
    "createdAt": createdAt,
  };
}
