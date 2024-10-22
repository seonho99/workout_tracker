import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker/workout_manager.dart';
import 'workout.dart';

class WorkoutListPage extends StatelessWidget {
  int groupIndex;
  WorkoutListPage({super.key,required this.groupIndex}){
    WorkoutManager.currentWorkoutGroupIndex=groupIndex;
  }

  final List<Workout> workouts = WorkoutManager.workouts;

  List<GestureDetector> getWorkoutList(BuildContext context) {
    List<Workout> workouts = WorkoutManager.workoutGroups[groupIndex].workouts;
    List<GestureDetector> workoutListRow = [];
    for (var i = 0; i < workouts.length; i++) {
      var name = workouts[i].name;
      var image = workouts[i].imageName;
      var minutes = workouts[i].minutes;
      workoutListRow.add(
        GestureDetector(
          onTap: (){
            context.go('/workout_home/workout_list/$groupIndex/workout_guide/$i');
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow,
                    image: DecorationImage(
                      image: AssetImage('assets/$image'),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(
                  '${i + 1}.$name',
                  style: TextStyle(fontSize: 20),
                )),
                Text(
                  '$minutes 분',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                )
              ],
            ),
          ),
        ),
      );
    }
    return workoutListRow;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WorkoutList'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: getWorkoutList(context),
          ),
        ),
      ),
    );
  }
}
