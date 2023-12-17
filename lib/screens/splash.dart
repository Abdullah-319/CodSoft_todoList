import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list/screens/todo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 1),
      () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const HomeScreen()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset("lib/assets/taskMaster.png"),
      ),
    );
  }
}
