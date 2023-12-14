import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/Services/shared_pref.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/providers/tasks_list.dart';

class DoneScreen extends ConsumerStatefulWidget {
  const DoneScreen({super.key});

  @override
  ConsumerState<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends ConsumerState<DoneScreen> {
  void _markAsUndone(TaskModel task) {
    setState(() {
      task.isDone = false;
      Navigator.of(context).pop();
    });
  }

  void _removeTask(TaskModel task) {
    setState(() {
      ref.read(tasksNotifier.notifier).removeTask(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    final completedTasks = ref.watch(tasksNotifier.notifier).completedTasks();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 224, 188),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.keyboard_arrow_right,
              size: 36,
              color: Color.fromARGB(255, 117, 46, 207),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text(
                'Completed',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: completedTasks.isEmpty
                  ? Center(
                      child: Text(
                        'No Tasks done',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: completedTasks.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Dismissible(
                            onDismissed: (direction) {
                              _removeTask(completedTasks[index]);
                              SharedPrefService.setToDoList(
                                  ref.read(tasksNotifier));
                            },
                            key: GlobalKey(),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
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
                                              _markAsUndone(
                                                  completedTasks[index]);
                                            });
                                          },
                                          child: Image.asset(
                                            'lib/assets/done.png',
                                            height: 30,
                                            width: 30,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              completedTasks[index].title,
                                              style: GoogleFonts.inter(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              formatter.format(
                                                  completedTasks[index].date),
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
                                        _removeTask(completedTasks[index]);
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
                        );
                      }),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
