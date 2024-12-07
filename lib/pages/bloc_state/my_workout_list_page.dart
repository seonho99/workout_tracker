import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/bloc/workout_bloc/workout_bloc.dart';
import 'package:workout_tracker/data/bloc/workout_bloc/workout_event.dart';
import 'package:workout_tracker/data/workout.dart';
import 'package:workout_tracker/pages/bloc_state/add_workout_dialog.dart';
import 'package:workout_tracker/pages/bloc_state/workout_tile.dart';
import '../../data/bloc/workout_bloc/workout_state.dart';
import '../../data/workout_manager.dart';

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
    super.initState();
    context.read<WorkoutBloc>().add(LoadWorkouts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyWorkoutList'),
      ),
      body: BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          switch (state) {
            case WorkoutInitial():
              return Center(
                child: CircularProgressIndicator(),
              );
            case WorkoutLoaded():
              List<Workout> workouts = state.workouts;
              return ListView.builder(
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  return WorkoutTile(
                    index: index,

                  );
                },
              );
            default:
              return Center(
                child: Text('Something went wrong!'),
              );
          }
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
