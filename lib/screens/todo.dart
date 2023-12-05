import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Daily Tasks',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
          // child: ListView.builder(
          //   itemCount: 4,
          //   itemBuilder: ((context, index) => const ListTile(
          //         leading: Icon(Icons.done, color: Colors.white),
          //         title: Text('title'),
          //         trailing: Text('desc'),
          //       )),
          // ),
        ),
      ),
    );
  }
}
