import 'package:workout_tracker/data/days_of_week.dart';

class Workout {
  String? id;
  String name;
  int minutes;
  String imageName;
  String audioName;
  int kcal;
  Set<DaysOfWeek>? workoutDays;
  String? uid;
  DateTime createdAt;

  Workout(
      {this.id,
      required this.name,
      required this.minutes,
      required this.imageName,
      required this.audioName,
      required this.kcal,
      this.workoutDays,
      this.uid,
      createdAt})
      : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    List<int> workoutDaysList = [];
    if (workoutDays != null) {
      for (var day in workoutDays!) {
        workoutDaysList.add(day.index);
      }
    }
    return {
      'id': id,
      'name': name,
      'minutes': minutes,
      'imageName': imageName,
      'audioName': audioName,
      'kcal': kcal,
      'workoutDays': workoutDays?.map((day) => day.index).toList(),
      'uid': uid,
      'createdAt': createdAt,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    Set<DaysOfWeek>? dayOfWeek;
    if (map['workoutDays'] != null) {
      dayOfWeek = Set<DaysOfWeek>.from(
          map['workoutDays'].map((day) => DaysOfWeek.values[day]));
    }
    return Workout(
      id: map['id'],
      uid: map['uid'],
      name: map['name'],
      minutes: map['minutes'],
      imageName: map['imageName'],
      audioName: map['audioName'],
      kcal: map['kcal'],
      workoutDays: dayOfWeek,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'].seconds*1000),
    );
  }
}
