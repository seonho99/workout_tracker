import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/data/provider/workout_provider.dart';
import 'package:workout_tracker/data/workout_manager.dart';
import 'package:workout_tracker/pages/provider_state/add_workout_dialog.dart';
import 'package:workout_tracker/pages/provider_state/workout_tile.dart';
import 'package:workout_tracker/show_snackbar.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<WorkoutProvider>().fetchAllWorkouts().catchError((e){
      showSnackBar(context, e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyWorkoutList'),
      ),
      body: Consumer<WorkoutProvider>(
        builder: (context, workoutProvider, child) {
          List<Workout> workouts = [];
          if(workouts.isEmpty){
            return Center(
              child: Text(
                  '등록된 운동이 없습니다.\n운동을 추가하세요',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
          }
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
