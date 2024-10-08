import 'package:flutter/material.dart';
import 'workout.dart';

class WorkoutListPage extends StatelessWidget {
  WorkoutListPage({super.key});

  List<Workout> workouts = [
    Workout(
        name: '스쿼트',
        minutes: 30,
        imageName: 'squat.jpeg',
        audioName: 'squat.mp3',
        kcal: 200),
    Workout(
        name: '사이드런지',
        minutes: 20,
        imageName: 'side_lunge.jpeg',
        audioName: 'side_lunge.mp3',
        kcal: 100),
    Workout(
        name: '푸쉬업',
        minutes: 15,
        imageName: 'pushup.jpeg',
        audioName: 'pushup.mp3',
        kcal: 100),
    Workout(
        name: '마운틴클림버',
        minutes: 15,
        imageName: 'mountain_climber.jpeg',
        audioName: 'mountain_climber.mp3',
        kcal: 50),
    Workout(
        name: '런지',
        minutes: 20,
        imageName: 'lunge.jpeg',
        audioName: 'lunge.mp3',
        kcal: 100),
    Workout(
        name: '덤벨컬',
        minutes: 40,
        imageName: 'dumbell_curl.jpeg',
        audioName: 'dumbell_curl.mp3',
        kcal: 200),
    Workout(
        name: '덩키킥',
        minutes: 30,
        imageName: 'donkey_kick.jpeg',
        audioName: 'donkey_kick.mp3',
        kcal: 50),
    Workout(
        name: '친업',
        minutes: 25,
        imageName: 'chinup.jpeg',
        audioName: 'chinup.mp3',
        kcal: 300),
    Workout(
        name: '벤치프레스',
        minutes: 10,
        imageName: 'benchpress.jpeg',
        audioName: 'benchpress.mp3',
        kcal: 250),
  ];
  

  List<GestureDetector> getWokroutList() {
    List<GestureDetector> workoutListRow = [];
    for (var i = 0; i < workouts.length; i++) {
      var name = workouts[i].name;
      var image = workouts[i].imageName;
      var minutes = workouts[i].minutes;
      workoutListRow.add(
        GestureDetector(
          onTap: (){

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
            children: getWokroutList(),
          ),
        ),
      ),
    );
  }
}
