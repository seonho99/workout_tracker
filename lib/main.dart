import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workout_tracker/firebase_options.dart';
import 'firebase_options.dart';

import 'my_router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Workout Tracker',
      routerConfig: router,
      // home: WorkoutHomePage(),
    );
  }
}
