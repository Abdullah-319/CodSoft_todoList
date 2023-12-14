import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/models/task.dart';

class TasksNotifier extends StateNotifier<List<TaskModel>> {
  TasksNotifier() : super(const []);

  void addTask(TaskModel task) {
    state = [task, ...state];
    state.sort((a, b) => a.date.compareTo(b.date));
  }

  void removeTask(TaskModel task) {
    state = state.where((t) => t.title != task.title).toList();
  }

  List<TaskModel> completedTasks() {
    final cmp = state.where((task) => task.isDone == true).toList();
    return cmp;
  }

  List<TaskModel> incompleteTasks() {
    final inn = state.where((task) => task.isDone == false).toList();
    return inn;
  }
}

final tasksNotifier = StateNotifierProvider<TasksNotifier, List<TaskModel>>(
  (ref) => TasksNotifier(),
);
