import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/bloc/repository/workout_repository.dart';
import 'package:workout_tracker/data/days_of_week.dart';

import '../../workout.dart';
import 'workout_event.dart';
import 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final WorkoutRepository workoutRepository;

  WorkoutBloc(this.workoutRepository) : super(WorkoutInitial()) {
    on<LoadWorkouts>((event, emit) async {
      List<Workout> workouts = workoutRepository.fetchWorkouts();
      await Future.delayed(Duration(seconds: 2));
      emit(WorkoutLoaded(workouts));
    });

    on<AddWorkout>((event, emit) async {
      List<Workout> workouts = state.workouts;
      workouts.add(event.workout);
      emit(WorkoutLoaded(workouts));
    });

    on<DeleteWorkout>((event, emit) async {
      List<Workout> workouts = state.workouts;
      workoutRepository.deleteWorkout(workouts[event.workoutIndex]);
      workouts.removeAt(event.workoutIndex);
      emit(WorkoutLoaded(workouts));
    });

    on<UpdateWorkout>((event, emit) async {
      List<Workout> workouts = state.workouts;

      workouts[event.workoutIndex].workoutDays = await updateWorkoutDays(
        selectedDay: event.selectedDay,
        workoutDays: event.workoutDays,
      );

      workoutRepository.updateWorkout(workouts[event.workoutIndex]);
      emit(WorkoutLoaded(workouts));
    });
  }

  Future<Set<DaysOfWeek>> updateWorkoutDays({
    required DaysOfWeek selectedDay,
    Set<DaysOfWeek>? workoutDays,
  }) async {
    Set<DaysOfWeek> workoutDaysLocal = workoutDays ?? {};
    if (workoutDaysLocal.contains(selectedDay)) {
      workoutDaysLocal.remove(selectedDay);
    } else {
      workoutDaysLocal.add(selectedDay);
    }
    return workoutDaysLocal;
  }

  List<bool> changeWorkoutDaysToIsSelected(Set<DaysOfWeek>? workoutDays){
    List<bool> isSelected = List.filled(7, false);
    if(workoutDays == null){
      return isSelected;
    }
    for (var week in workoutDays){
      isSelected[week.index] = true;
    }
    return isSelected;
  }
}
