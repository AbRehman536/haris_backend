// To parse this JSON data, do
//
//     final priorityModel = priorityModelFromJson(jsonString);

import 'dart:convert';

class PriorityModel {
  final String? docId;
  final String? name;
  final int? createdAt;

  PriorityModel({
    this.docId,
    this.name,
    this.createdAt,
  });

  factory PriorityModel.fromJson(Map<String, dynamic> json) => PriorityModel(
    docId: json["docId"],
    name: json["name"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String priorityID) => {
    "docId": priorityID,
    "name": name,
    "createdAt": createdAt,
  };
}
