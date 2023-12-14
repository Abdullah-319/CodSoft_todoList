import 'dart:convert';

import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class TaskModel {
  final String title;
  final DateTime date;
  final String description;
  bool isDone;

  TaskModel({
    required this.title,
    required this.date,
    required this.description,
    this.isDone = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
      title: json["title"],
      description: json["description"],
      date: DateTime.parse(json["date"]),
      isDone: json["isDone"]);

  static Map<String, dynamic> toMap(TaskModel data) => {
        "title": data.title,
        "description": data.description,
        "date": data.date.toString(),
        "isDone": data.isDone
      };

  static String encode(List<TaskModel> products) => json.encode(products
      .map<Map<String, dynamic>>((product) => TaskModel.toMap(product))
      .toList());

  static List<TaskModel> decode(String products) {
    try {
      return (json.decode(products) as List<dynamic>)
          .map<TaskModel>((item) => TaskModel.fromJson(item))
          .toList();
    } catch (e) {
      return [];
    }
  }

  String get formattedDate {
    return formatter.format(date);
  }
}
