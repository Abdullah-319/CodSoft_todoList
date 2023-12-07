class Task {
  Task({required this.title, required this.date, required this.description})
      : isDone = false;

  final String title;
  final DateTime date;
  final String description;
  bool isDone;
}
