import 'dart:collection';

import 'package:flutter/material.dart';
import '../days_of_week.dart';
import '../workout.dart';

class WorkoutProvider extends ChangeNotifier{
  final List<Workout> _workouts = [
    Workout(
        name: '바벨 활용 종아리 운동',
        minutes: 15,
        imageName:
        'https://firebasestorage.googleapis.com/v0/b/workout-tracker-a368c.appspot.com/o/workout_images%2F04171301-Dumbbell-Standing-Calf-Raise_Calf_360%20Small.jpeg?alt=media&token=656116ab-11ef-414c-8049-03d586098ad7',
        audioName: 'https://firebasestorage.googleapis.com/v0/b/workout-tracker-a368c.appspot.com/o/workout_images%2F01111301-Barbell-Standing-Rocking-Leg-Calf-Raise_Calf_360%20Small.jpeg?alt=media&token=9ae6215b-ecf6-474b-a494-11270d02b836',
        kcal: 320,
        workoutDays: {DaysOfWeek.mon, DaysOfWeek.wed}),
    Workout(
        name: '덤벨 활용 앉아서 종아리 운동',
        minutes: 4,
        imageName:
        'https://firebasestorage.googleapis.com/v0/b/workout-tracker-a368c.appspot.com/o/workout_images%2F01111301-Barbell-Standing-Rocking-Leg-Calf-Raise_Calf_360%20Small.jpeg?alt=media&token=9ae6215b-ecf6-474b-a494-11270d02b836',
        audioName: 'https://firebasestorage.googleapis.com/v0/b/workout-tracker-a368c.appspot.com/o/workout_mpp3%2FQuartz.mp3?alt=media&token=02eca3a2-7829-41dd-a004-c8bfce934199',
        kcal: 110,
        workoutDays: {DaysOfWeek.fri, DaysOfWeek.sat}),
  ];

  void addWorkout(Workout workout){
    _workouts.add(workout);
    notifyListeners();
  }

  void deleteWorkout(int deleteIndex){
    _workouts.removeAt(deleteIndex);
    notifyListeners();
  }

  List<Workout> get workouts {
   return UnmodifiableListView(_workouts);
  }

  List<bool> changeWorkoutDaysToIsSelected(Set<DaysOfWeek>? workoutDays){
    List<bool> isSelected = List.filled(7, false);

    if(workoutDays== null){
      return isSelected;
    }
    for (var week in workoutDays){
      isSelected[week.index] = true;
    }
    return isSelected;
  }

  void updateWorkoutDays({
    required DaysOfWeek selectedDay,
    required int workoutIndex,
    Set<DaysOfWeek>? workoutDays,
}){
    Set<DaysOfWeek> workoutDaysLocal = workoutDays ?? {};
    if(workoutDaysLocal.contains(selectedDay)){
      workoutDaysLocal.remove(selectedDay);
    }else{
      workoutDaysLocal.add(selectedDay);
    }
    _workouts[workoutIndex].workoutDays = workoutDaysLocal;
    notifyListeners();
  }
}