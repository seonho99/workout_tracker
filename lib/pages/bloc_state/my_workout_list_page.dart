import 'package:flutter/material.dart';
import 'package:workout_tracker/data/days_of_week.dart';
import 'package:workout_tracker/data/workout_manager.dart';
import 'package:workout_tracker/pages/bloc_state/add_workout_dialog.dart';
import 'package:workout_tracker/pages/bloc_state/workout_tile.dart';
import '../../data/workout.dart';

class MyWorkoutListPage extends StatefulWidget {
  MyWorkoutListPage({super.key}) {
    WorkoutManager.increaseMonthlyWorkoutCount();
  }

  @override
  State<MyWorkoutListPage> createState() => _MyWorkoutListPageState();
}

class _MyWorkoutListPageState extends State<MyWorkoutListPage> {
  List<Workout> workouts = [
    Workout(
        name: '바벨활용 종아리 운동',
        minutes: 15,
        imageName:
            'https://firebasestorage.googleapis.com/v0/b/workout-tracker-a368c.appspot.com/o/workout_images%2F04171301-Dumbbell-Standing-Calf-Raise_Calf_360%20Small.jpeg?alt=media&token=656116ab-11ef-414c-8049-03d586098ad7',
        audioName: 'https://firebasestorage.googleapis.com/v0/b/workout-tracker-a368c.appspot.com/o/workout_images%2F01111301-Barbell-Standing-Rocking-Leg-Calf-Raise_Calf_360%20Small.jpeg?alt=media&token=9ae6215b-ecf6-474b-a494-11270d02b836',
        kcal: 320,
        workoutDays: {DaysOfWeek.mon, DaysOfWeek.wed}),
    Workout(
        name: '덤벨활용 앉아서 종아리 운동',
        minutes: 4,
        imageName:
            'https://firebasestorage.googleapis.com/v0/b/workout-tracker-a368c.appspot.com/o/workout_images%2F01111301-Barbell-Standing-Rocking-Leg-Calf-Raise_Calf_360%20Small.jpeg?alt=media&token=9ae6215b-ecf6-474b-a494-11270d02b836',
        audioName: 'https://firebasestorage.googleapis.com/v0/b/workout-tracker-a368c.appspot.com/o/workout_mpp3%2FQuartz.mp3?alt=media&token=02eca3a2-7829-41dd-a004-c8bfce934199',
        kcal: 110,
        workoutDays: {DaysOfWeek.fri, DaysOfWeek.sat}),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyWorkoutList'),
      ),
      body: ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          return WorkoutTile(
            index: index,
            name: workouts[index].name,
            image: workouts[index].imageName,
            minutes: workouts[index].minutes,
            workoutDays: workouts[index].workoutDays??{},
            deleteWorkout: (deleteIndex) {
              setState(() {
                workouts.removeAt(deleteIndex);
              });
            },
            updateWorkoutDays: (List<bool> isSelected) {
              Set<DaysOfWeek> selectedWorkoutDays = {};
              for (var weekDay in DaysOfWeek.values) {
                if (isSelected[weekDay.index]) {
                  selectedWorkoutDays.add(weekDay);
                }
              }
              workouts[index].workoutDays = selectedWorkoutDays;
            },
          );
        },
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
                addWorkoutCallback: (Workout? newWorkout) {
                  if (newWorkout == null) return;
                  setState(() {
                    workouts.add(newWorkout);
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
