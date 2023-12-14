import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:todo_list/models/task.dart';
import 'package:todo_list/providers/tasks_list.dart';
import 'package:todo_list/screens/create_task.dart';
import 'package:todo_list/screens/done.dart';

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

  void _removeTask(Task task) {
    setState(() {
      ref.read(tasksNotifier.notifier).removeTask(task);
    });
  }

  void _markAsDone(Task task) {
    setState(() {
      task.isDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final undoneTasks =
        ref.watch(tasksNotifier).where((task) => task.isDone == false).toList();

    return Scaffold(
      appBar: AppBar(),
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
            const SizedBox(height: 45),
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
                      child: Text(
                        'No Tasks to show',
                        style: GoogleFonts.inter(
                          color: Colors.deepPurple,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
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
                            },
                            key: GlobalKey(),
                            child: GestureDetector(
                              onTap: () {},
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
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const CreateTaskScreen()));
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(45),
            child: Image.asset('lib/assets/addIcon.png')),
      ),
    );
  }
}
