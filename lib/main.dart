import 'package:flutter/material.dart';
import 'package:workout_tracker/workout_home_page.dart';
import 'landing_page.dart';
import 'workout_list_page.dart';
import 'workout_guide_page.dart';
import 'my_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Tracker',
      home: LandingPage(),
    );
  }
}
