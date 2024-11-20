import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/data/days_of_week.dart';
import 'package:workout_tracker/data/provider/workout_provider.dart';
import 'package:workout_tracker/data/workout_manager.dart';
import 'package:workout_tracker/pages/provider_state/add_workout_dialog.dart';
import 'package:workout_tracker/pages/provider_state/workout_tile.dart';
import '../../data/workout.dart';

class MyWorkoutListPage extends StatefulWidget {
  MyWorkoutListPage({super.key}) {
    WorkoutManager.increaseMonthlyWorkoutCount();
  }

  @override
  State<MyWorkoutListPage> createState() => _MyWorkoutListPageState();
}

class _MyWorkoutListPageState extends State<MyWorkoutListPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyWorkoutList'),
      ),
      body: Consumer<WorkoutProvider>(
        builder: (context, workoutProvider, child) {
          List<Workout> workouts = workoutProvider.workouts;
          return ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              return WorkoutTile(
                index: index,
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              backgroundColor: Colors.transparent,
              child: AddWorkoutDialog(
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
