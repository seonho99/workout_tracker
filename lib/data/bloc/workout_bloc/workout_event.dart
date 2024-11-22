
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
  final DaysOfWeek selectedDay;
  final Set<DaysOfWeek>? workoutDays;

  UpdateWorkout(
      {required this.workoutIndex, required this.selectedDay, this.workoutDays});
}

final class DeleteWorkout extends WorkoutEvent {
  final int workoutIndex;

  DeleteWorkout(this.workoutIndex);

}
