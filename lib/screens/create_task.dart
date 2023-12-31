import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:todo_list/Services/shared_pref.dart';
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
    ref.read(tasksNotifier.notifier).addTask(TaskModel(
          title: _titleController.text,
          date: _selectedDate!,
          description: _descController.text,
        ));
    SharedPrefService.setToDoList(ref.read(tasksNotifier));
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
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
              size: 36,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
                  const SizedBox(height: 16),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    maxLength: 15,
                    controller: _titleController,
                    decoration: InputDecoration(
                      label: const Text('Title'),
                      counterStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          style: BorderStyle.solid,
                        ),
                      ),
                      labelStyle: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    maxLength: 100,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: const Text('Description'),
                      counterStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      labelStyle: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    controller: _descController,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    _selectedDate == null
                        ? 'No Date Selected'
                        : formatter.format(_selectedDate!),
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: const Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 150),
                  ElevatedButton.icon(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.pinkAccent,
                      ),
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 110, vertical: 15),
                      ),
                    ),
                    onPressed: _addTask,
                    icon: Image.asset(
                      'lib/assets/taskDone.png',
                      height: 30,
                      width: 30,
                    ),
                    label: Text(
                      'Done',
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
