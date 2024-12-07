import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:workout_tracker/data/services/firebase_auth_service.dart';
import '../days_of_week.dart';
import '../services/firestore_service.dart';
import '../workout.dart';

class WorkoutProvider extends ChangeNotifier {
  final _firestoreService = FirestoreService();
  final FirebaseAuthService auth = FirebaseAuthService();

  final List<Workout> _workouts = [];

  Future<void> addWorkout(Workout workout) async {
    workout.uid = auth.user?.uid;

    try {
      await _firestoreService.createWorkout(workout);
      _workouts.add(workout);
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> deleteWorkout(int deleteIndex) async {
    if (_workouts[deleteIndex].id == null) throw Exception('삭제할 수 없습니다.');
    await _firestoreService.deleteWorkout(_workouts[deleteIndex].id!);
    _workouts.removeAt(deleteIndex);
    notifyListeners();
  }

  List<Workout> get workouts {
    return UnmodifiableListView(_workouts);
  }

  List<bool> changeWorkoutDaysToIsSelected(Set<DaysOfWeek>? workoutDays) {
    List<bool> isSelected = List.filled(7, false);

    if (workoutDays == null) {
      return isSelected;
    }
    for (var week in workoutDays) {
      isSelected[week.index] = true;
    }
    return isSelected;
  }

  Future<void> updateWorkoutDays({
    required DaysOfWeek selectedDay,
    required int workoutIndex,
    Set<DaysOfWeek>? workoutDays,
  }) async {
    Set<DaysOfWeek> workoutDaysLocal = workoutDays ?? {};
    if (workoutDaysLocal.contains(selectedDay)) {
      workoutDaysLocal.remove(selectedDay);
    } else {
      workoutDaysLocal.add(selectedDay);
    }
    _workouts[workoutIndex].workoutDays = workoutDaysLocal;
    await _firestoreService.updateWorkout(_workouts[workoutIndex]);
    notifyListeners();
  }

  Future<void> fetchAllWorkouts() async {
    if (auth.user == null) return;
    final List<Workout> fetchedWorkouts =
        await _firestoreService.fetchAllWorkouts(uid: auth.user!.uid);
    _workouts.addAll(fetchedWorkouts);
    notifyListeners();
  }
}
