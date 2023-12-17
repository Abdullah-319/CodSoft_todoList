import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: !task.isDone
          ? const Color.fromARGB(255, 35, 35, 40)
          : Colors.pinkAccent,
      appBar: AppBar(
        title: Text(
          "${task.title} (${task.formattedDate})",
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData().copyWith(
          color: Colors.white,
          size: 20,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            task.description,
            style: TextStyle(
              color: !task.isDone ? Colors.grey : Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
