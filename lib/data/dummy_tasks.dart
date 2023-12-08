import 'package:todo_list/models/task.dart';

final List<Task> tasks = [
  Task(
    title: 'Task 1',
    date: DateTime(2022),
    description: 'My first task',
  ),
  Task(
    title: 'Task 2',
    date: DateTime(2021),
    description: 'My second task',
  ),
  Task(
    title: 'Task 3',
    date: DateTime(2020),
    description: 'My third task',
  ),
  Task(
    title: 'Task 4',
    date: DateTime(2019),
    description: 'My fourth task',
  ),
];

final List<Task> completedTasks =
    tasks.where((task) => task.isDone == true).toList();
