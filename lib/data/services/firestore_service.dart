import 'package:cloud_firestore/cloud_firestore.dart';

import '../workout.dart';

class FirestoreService {
  FirebaseFirestore _fs = FirebaseFirestore.instance;

  // 생성
  Future<void> createWorkout(Workout workout) async {
    final workoutsCollection = _fs.collection('workouts');
    final docRef = await workoutsCollection.add(workout.toMap());
    docRef.update({'id':docRef.id});

    await workoutsCollection.add(workout.toMap());
  }

  // 읽기
  Future<Workout?> readWorkout(String workoutId) async {
    return null;
  }

  // 수정
  Future<void> updateWorkout(Workout workout) async {

  }

  // 삭제
  Future<void> deleteWorkout(String workoutId) async {

  }

}