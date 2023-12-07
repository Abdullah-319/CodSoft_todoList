import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/data/dummy_tasks.dart';
import 'package:todo_list/models/task.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({super.key});

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  void _markAsUndone(Task task) {
    setState(() {
      task.isDone = false;
      tasks.add(task);
      completedTasks.remove(task);
    });
  }

  void _removeTask(Task task) {
    setState(() {
      completedTasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
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
              child: ListView.builder(
                itemCount: completedTasks.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 15, 0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
                      titleAlignment: ListTileTitleAlignment.center,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      tileColor: Colors.white,
                      leading: GestureDetector(
                        onTap: () {
                          _markAsUndone(completedTasks[index]);
                        },
                        child: Image.asset(
                          'lib/assets/done.png',
                          height: 30,
                          width: 30,
                        ),
                      ),
                      title: Text(
                        completedTasks[index].title,
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      isThreeLine: true,
                      subtitle: Text(
                        completedTasks[index].date.toString(),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          _removeTask(completedTasks[index]);
                        },
                        child: Image.asset('lib/assets/deleteIcon.png'),
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
