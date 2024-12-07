import 'package:cloud_firestore/cloud_firestore.dart';
import '../workout.dart';

class FirestoreService{
  final FirebaseFirestore _fs = FirebaseFirestore.instance;

  Future<void> createWorkout(Workout workout) async {
    final workoutsCollection = _fs.collection('workouts');
    final docRef = await workoutsCollection.add(workout.toMap());
    docRef.update({'id':docRef.id});

  }

  Future<List<Workout>> fetchAllWorkouts({required String uid,int limit=5, Workout? lastWorkout}) async {
    final _workoutsCollection = _fs.collection('workouts');
    List<Workout> returnData = [];

    try {


      final QuerySnapshot<
          Map<String, dynamic>> querySnapshot = await _workoutsCollection
          .where('uid', isEqualTo: uid)
          .orderBy('createdAt')
          .orderBy('id')
          .get();

      final queryDocumentSnapshot = querySnapshot.docs;
      for (final QueryDocumentSnapshot<
          Map<String, dynamic>> doc in queryDocumentSnapshot) {
        returnData.add(Workout.fromMap(doc.data()));
      }
    } catch(e){
      print(e);
      throw Exception('fetch error');
    }

    return returnData;

  }

  Future<Workout?> readWorkout(String workoutId) async {
    final workoutsCollection = _fs.collection('workouts');
    final documentSnapshot = await workoutsCollection.doc(workoutId).get();
    if(!documentSnapshot.exists) throw('no data');
    final mapData = documentSnapshot.data()!;
    return Workout.fromMap(mapData);

  }


  Future<void> updateWorkout(Workout workout) async {
    if (workout.workoutDays == null) return;
    final workoutsCollection = _fs.collection('workouts');
    try {
      await workoutsCollection.doc(workout.id).update(workout.toMap());
    } catch (e) {
      throw Exception('update 실패:$e');
    }
  }


  Future<void> deleteWorkout(String workoutId) async {
    final workoutCollection = _fs.collection('workouts');

    try {
      final documentReference = workoutCollection.doc(workoutId);
      documentReference.delete();
    } catch (e) {
      throw Exception('delete 실패: $e');
    }
  }
}