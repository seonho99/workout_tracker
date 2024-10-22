import 'package:workout_tracker/workout.dart';

class WorkoutGroup {
  String groupDescription;

  List<Workout> workouts;
  WorkoutGroup({required this.groupDescription, required this.workouts});
}