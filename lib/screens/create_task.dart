import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/providers/tasks_list.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final _titleController = TextEditingController();
  DateTime? _selectedDate;
  final _descController = TextEditingController();

  void _presentDatePicker() async {
    DateTime now = DateTime.now();
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: now,
        lastDate: DateTime(now.year + 10, now.month, now.day));
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _addTask() {
    if (_titleController.text.trim().isEmpty ||
        _descController.text.trim().isEmpty ||
        _selectedDate == null) {
      _displayDialog();
      return;
    }

    ref.read(tasksNotifier.notifier).addTask(Task(
          title: _titleController.text,
          date: _selectedDate!,
          description: _descController.text,
        ));

    Navigator.pop(context);
  }

  void _displayDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) {
          return CupertinoAlertDialog(
            title: const Text('Invalid input'),
            content: const Text('Please fill in all fields correctly!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Okay'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Invalid input'),
            content: const Text('Please fill in all fields correctly!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Okay'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Color.fromARGB(255, 117, 46, 207),
                size: 36,
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 0, 0),
              child: Text(
                'Add new',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                  ),
                  Text(
                    _selectedDate == null
                        ? 'No Date Selected'
                        : formatter.format(_selectedDate!),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: const Icon(
                      Icons.calendar_month,
                    ),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      label: Text('Description'),
                    ),
                    controller: _descController,
                  ),
                  const SizedBox(height: 206),
                  TextButton.icon(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 117, 46, 207),
                      ),
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 106, vertical: 20),
                      ),
                    ),
                    onPressed: _addTask,
                    icon: Image.asset(
                      'lib/assets/taskDone.png',
                      height: 30,
                      width: 30,
                    ),
                    label: Text(
                      'Create Task',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
