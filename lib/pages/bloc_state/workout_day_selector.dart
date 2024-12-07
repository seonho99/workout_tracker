import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/bloc/workout_bloc/workout_event.dart';

import '../../data/bloc/workout_bloc/workout_bloc.dart';
import '../../data/days_of_week.dart';

class WorkoutDaySelector extends StatefulWidget {
  final int workoutIndex;

  const WorkoutDaySelector({super.key, required this.workoutIndex});

  @override
  State<WorkoutDaySelector> createState() => _WorkoutDaySelectorState();
}

class _WorkoutDaySelectorState extends State<WorkoutDaySelector> {
  List<bool> isSelected = List.filled(7, false);
  Set<DaysOfWeek> selectedWorkoutDays={};

  @override
  void initState() {
    super.initState();
    isSelected = context.read<WorkoutBloc>().changeWorkoutDaysToIsSelected(
      context.read<WorkoutBloc>().state.workouts[widget.workoutIndex].workoutDays
    );
  }

  void updateIsSelected(int index){
    isSelected[index] = !isSelected[index];

    context.read<WorkoutBloc>().add(
      UpdateWorkout(
        selectedDay: DaysOfWeek.fromIndex(index),
          workoutIndex: widget.workoutIndex,
          workoutDays: context.read<WorkoutBloc>().state.workouts[widget.workoutIndex].workoutDays,
      ),
    );
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
