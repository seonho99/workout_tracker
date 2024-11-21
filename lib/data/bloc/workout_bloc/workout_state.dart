import '../../workout.dart';

sealed class WorkoutState{
  final List<Workout> workouts;
  WorkoutState({required this.workouts});
}

// 초기화
final class WorkoutInitial extends WorkoutState {
  WorkoutInitial(): super(workouts: []);
}


// 목록 바꿀시
final class WorkoutLoaded extends WorkoutState {
  WorkoutLoaded(List<Workout> workouts) : super(workouts: workouts);
}