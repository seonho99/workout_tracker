import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/data/provider/workout_provider.dart';
import 'package:workout_tracker/firebase_options.dart';

import 'my_router.dart';

void main() async {
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> WorkoutProvider()),
        ],
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Workout Tracker',
      ),
    );
    // MultiRepositoryProvider(
    //     providers: [
    //     RepositoryProvider<WorkoutRepository>(
    // create: (context) => WorkoutRepository(FakeDb()),
    // ),
    //     ],
    //   child: MultiBlocProvider(
    //   providers: [
    //     BlocProvider<WorkoutBloc>(
    //         create: (context) => WorkoutBloc(context.read<WorkoutRepository>()),
    //     ),
    //   ],
    //   child: MaterialApp.router(
    //     title: 'Workout Tracker',
    //     routerConfig: router,
    //   ),
    //     // home: WorkoutHomePage(),
    //   ),
    // );
  }
}
