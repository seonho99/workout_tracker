import '../days_of_week.dart';
import '../workout.dart';

class FakeDb{
  static final List<Workout> _workouts = [
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

  List<Workout> fetchWorkouts(){
    return List.from(_workouts);
  }

  Workout getWorkout(int index){
    return _workouts.elementAt(index);
  }

  void addWorkout(Workout workout){
    _workouts.add(workout);
  }

  void deleteWorkout(Workout workout){
    _workouts.remove(workout);
  }

  void updateWorkout(Workout workout){
    int targetIndex = _workouts.indexOf(workout);
    _workouts[targetIndex]=workout;
  }
}