import 'package:workout_tracker/data/days_of_week.dart';

class Workout {
  String? id;
  String name;
  int minutes;
  String imageName;
  String audioName;
  int kcal;
  Set<DaysOfWeek>? workoutDays;

  Workout({
    this.id,
    required this.name,
    required this.minutes,
    required this.imageName,
    required this.audioName,
    required this.kcal,
    this.workoutDays,
  });

  Map<String, dynamic> toMap(){
    List<int> workoutDaysList = [];

    if(workoutDays != null){
      for (var day in workoutDays!){
        workoutDaysList.add(day.index);
      }
    }

    return {
      'id':id,
      'name': name,
      'minutes': minutes,
      'imageName': imageName,
      'audioName': audioName,
      'kcal': kcal,
      'workoutDays':workoutDaysList,
    };
  }
}


