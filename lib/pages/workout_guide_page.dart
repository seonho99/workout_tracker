import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:workout_tracker/data/workout_manager.dart';
import '../data/workout.dart';

class WorkoutGuidePage extends StatefulWidget {
  int workoutsIndex;
  int groupIndex;

  WorkoutGuidePage({super.key,required this.workoutsIndex, required this.groupIndex});

  @override
  State<WorkoutGuidePage> createState() => _WorkoutGuidePageState();
}

class _WorkoutGuidePageState extends State<WorkoutGuidePage> {

  late List<Workout> workouts;

  final player = AudioPlayer();
  late Workout currentWorkout;
  int workoutsIndex=0;

  @override
  void initState() {
    super.initState();
    workouts = WorkoutManager.workoutGroups[widget.groupIndex].workouts;
    workoutsIndex=widget.workoutsIndex;
    currentWorkout=workouts[workoutsIndex];
  }


  IconButton getIconButton() {
    if (player.state == PlayerState.playing) {
      return IconButton(
        onPressed: () async {
          await player.stop();
          setState(() {});
        },
        icon: Icon(Icons.stop_circle),
        iconSize: 70,
        color: Colors.deepOrange,
      );
    } else {
      return IconButton(
        onPressed: () async {
          await player.play(AssetSource('${currentWorkout.audioName}'));
          setState(() {});
        },
        icon: Icon(Icons.play_circle_fill),
        iconSize: 70,
        color: Colors.deepOrange,
      );
    }
  }

  void nextWorkout(){
    if(workoutsIndex<workouts.length-1){
      workoutsIndex++;
    }else{
      workoutsIndex=0;
    }
    currentWorkout=workouts[workoutsIndex];
  }

  void prevWorkout(){
    if(workoutsIndex>0){
      workoutsIndex--;
    }else{
      workoutsIndex=workouts.length-1;
    }
    currentWorkout=workouts[workoutsIndex];
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WorkoutGuide'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '${currentWorkout.name}',
            style: TextStyle(fontSize: 35),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    await player.stop();
                    setState(() {
                      nextWorkout();
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: 70),
              Expanded(
                child: Image(
                  image: AssetImage('assets/${currentWorkout.imageName}'),
                ),
              ),
              IconButton(
                  onPressed: () async {
                    await player.stop();
                    setState(() {
                      prevWorkout();
                    });
                  },
                  icon: Icon(Icons.arrow_forward_ios),
                  iconSize: 70),
            ],
          ),
          Text(
            '${currentWorkout.minutes}',
            style: TextStyle(fontSize: 35, color: Colors.blue),
          ),
          getIconButton(),
        ],
      ),
    );
  }
}
