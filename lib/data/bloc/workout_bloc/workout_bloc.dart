import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/bloc/repository/workout_repository.dart';
import 'package:workout_tracker/data/days_of_week.dart';

import '../../workout.dart';
import 'workout_event.dart';
import 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final WorkoutRepository workoutRepository;

  WorkoutBloc(this.workoutRepository) : super(WorkoutInitial()) {
    on<LoadWorkouts>((event, emit) async {});
    on<AddWorkout>((event, emit) async {});
    on<DeleteWorkout>((event, emit) async {});
    on<UpdateWorkout>((event, emit) async {});
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
}
