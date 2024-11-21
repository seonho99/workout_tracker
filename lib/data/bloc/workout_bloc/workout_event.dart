
import '../../days_of_week.dart';
import '../../workout.dart';

sealed class WorkoutEvent {
  const WorkoutEvent();
}

final class LoadWorkouts extends WorkoutEvent {}

final class AddWorkout extends WorkoutEvent {
  final Workout workout;

  AddWorkout(this.workout);
}

final class UpdateWorkout extends WorkoutEvent {
  final int workoutIndex;
  final DaysOfWeek selectDay;
  final Set<DaysOfWeek>? weekoutDays;

  UpdateWorkout(
      {required this.workoutIndex, required this.selectDay, this.weekoutDays});
}

final class DeleteWorkout extends WorkoutEvent {
  final int workoutIndex;

  DeleteWorkout(this.workoutIndex);
}
