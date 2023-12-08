import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/models/task.dart';

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super(const []);

  void addTask(Task task) {
    state = [task, ...state];
  }

  void removeTask(Task task) {
    state = state.where((t) => t.title != task.title).toList();
  }
}

final tasksNotifier = StateNotifierProvider<TasksNotifier, List<Task>>(
  (ref) => TasksNotifier(),
);
