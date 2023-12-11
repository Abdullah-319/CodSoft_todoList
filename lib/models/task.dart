import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class Task {
  Task({required this.title, required this.date, required this.description})
      : isDone = false;

  final String title;
  final DateTime date;
  final String description;
  bool isDone;

  String get formattedDate {
    return formatter.format(date);
  }
}
