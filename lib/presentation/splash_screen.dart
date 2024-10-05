import 'package:flutter/material.dart';
import 'package:gradient_progress_indicator/widget/gradient_progress_indicator_widget.dart';
import 'package:todo_firebase_ui_template/presentation/login.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    splashNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: GradientProgressIndicator(
        radius: 120,
        duration: 3,
        strokeWidth: 12,
        gradientStops: [
          0.2,
          0.8,
        ],
        gradientColors: [
          Colors.white,
          Colors.grey,
        ],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ToDo Task Manger',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Text(
              'Loading',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> splashNavigation() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ScreenLogin()));
  }
}
