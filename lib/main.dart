import 'package:flutter/material.dart';
import 'package:todo_firebase_ui_template/presentation/login.dart';
import 'package:todo_firebase_ui_template/presentation/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: ScreenLogin()),
      ),
    );
  }
}
