import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/data/days_of_week.dart';
import 'package:workout_tracker/data/provider/workout_provider.dart';
import 'package:workout_tracker/show_snackbar.dart';

class WorkoutDaySelector extends StatefulWidget {
  final int workoutIndex;

  const WorkoutDaySelector(
      {super.key, required this.workoutIndex,});

  @override
  State<WorkoutDaySelector> createState() => _WorkoutDaySelectorState();
}

class _WorkoutDaySelectorState extends State<WorkoutDaySelector> {
  List<bool> isSelected = List.filled(7, false);
  Set<DaysOfWeek> selectedWorkoutDays = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSelected = Provider.of<WorkoutProvider>(
      context,
      listen: false,
    ).changeWorkoutDaysToIsSelected(context
        .read<WorkoutProvider>()
        .workouts[widget.workoutIndex]
        .workoutDays);
  }

  void updateIsSelected(int index) {
    isSelected[index] = !isSelected[index];

    Provider.of<WorkoutProvider>(
      context,
      listen: false,
    ).updateWorkoutDays(
        selectedDay: DaysOfWeek.fromIndex(index),
        workoutIndex: widget.workoutIndex,
      workoutDays: Provider.of<WorkoutProvider>(
          context,
          listen: false,
      ).workouts[widget.workoutIndex].workoutDays,
    ).catchError((e){
      showSnackBar(context, e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      onPressed: (index) {
        setState(() {
          updateIsSelected(index);
        });
      },
      isSelected: isSelected,
      children: [for (var item in DaysOfWeek.values) Text(item.kor)],
    );
  }
}
