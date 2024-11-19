import 'package:workout_tracker/data/days_of_week.dart';

class Workout {
  String name;
  int minutes;
  String imageName;
  String audioName;
  int kcal;
  Set<DaysOfWeek>? workoutDays;
  Workout({
    required this.name,
    required this.minutes,
    required this.imageName,
    required this.audioName,
    required this.kcal,
    this.workoutDays,
  });
}
