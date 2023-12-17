import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:todo_list/models/task.dart';
import 'package:todo_list/providers/tasks_list.dart';
import 'package:todo_list/screens/create_task.dart';
import 'package:todo_list/screens/done.dart';
import 'package:todo_list/screens/task_detail.dart';

import '../Services/shared_pref.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Future _moveToDoneScreen() {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const DoneScreen()));
  }

  void _removeTask(TaskModel task) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    var undoSnackbar = SnackBar(
      backgroundColor: const Color.fromARGB(255, 35, 35, 40),
      content: Text("You just removed ${task.title}"),
      action: SnackBarAction(
        label: "Undo",
        textColor: Colors.white,
        onPressed: () {
          ref.read(tasksNotifier.notifier).addTask(task);
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(undoSnackbar);

    setState(() {
      ref.read(tasksNotifier.notifier).removeTask(task);
    });
  }

  void _markAsDone(TaskModel task) {
    setState(() {
      task.isDone = true;
    });
  }

  @override
  void initState() {
    SharedPrefService.getToDoList().then((value) {
      value.sort((a, b) => b.date.compareTo(a.date));
      for (var element in value) {
        ref.watch(tasksNotifier.notifier).addTask(element);
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final undoneTasks =
        ref.watch(tasksNotifier).where((task) => task.isDone == false).toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text(
                'Daily Tasks',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                _moveToDoneScreen().then((value) => setState(() {}));
              },
              child: Container(
                height: 69,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: const Color.fromARGB(255, 23, 224, 188),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    Image.asset(
                      'lib/assets/done.png',
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'Completed',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                'To do Tasks',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: undoneTasks.isEmpty
                  ? Center(
                      child: Image.asset(
                        "lib/assets/empty.png",
                        height: 236,
                        width: 236,
                      ),
                    )
                  : ListView.builder(
                      itemCount: undoneTasks.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Dismissible(
                            onDismissed: (direction) {
                              _removeTask(undoneTasks[index]);
                              SharedPrefService.setToDoList(
                                  ref.read(tasksNotifier));
                            },
                            key: GlobalKey(),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => TaskDetailScreen(
                                        task: undoneTasks[index])));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color.fromARGB(255, 35, 35, 40),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(24, 24, 24, 24),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _markAsDone(undoneTasks[index]);
                                              });
                                              SharedPrefService.setToDoList(
                                                  ref.read(tasksNotifier));
                                              _moveToDoneScreen().then((value) {
                                                setState(() {});
                                              });
                                            },
                                            child: const Icon(
                                                Icons.circle_outlined),
                                          ),
                                          const SizedBox(width: 16),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                undoneTasks[index].title,
                                                style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                formatter
                                                    .format(
                                                        undoneTasks[index].date)
                                                    .toString(),
                                                style: GoogleFonts.inter(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _removeTask(undoneTasks[index]);
                                          SharedPrefService.setToDoList(
                                              ref.read(tasksNotifier));
                                        },
                                        child: Image.asset(
                                            'lib/assets/deleteIcon.png'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(100),
                ),
                height: 56,
                width: 56,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const CreateTaskScreen()));
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
