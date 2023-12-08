import 'package:riverpod/riverpod.dart';
import 'package:todo_list/models/task.dart';

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super(const []);

  void addTask(Task task) {
    state = [task, ...state];
  }
}

final tasksNotifier = StateNotifierProvider<TasksNotifier, List<Task>>(
  (ref) => TasksNotifier(),
);
