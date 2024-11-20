import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/data/provider/workout_provider.dart';

import '../../data/workout.dart';

class AddWorkoutDialog extends StatelessWidget {

  AddWorkoutDialog({super.key});

  String? newWorkoutTitle;
  String? newWorkoutImageUrl;
  String? newWorkoutAudioUrl;
  int newWorkoutMinutes = 0;
  int newWorkoutKcal = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Center(
              child: Text(
                '운동 추가',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(18, 3, 18, 3),
                    child: TextField(
                      onChanged: (String newTitle) {
                        newWorkoutTitle = newTitle;
                      },
                      decoration: InputDecoration(
                        labelText: '운동명',
                        border: InputBorder.none,
                        filled: true,
                      ),
                      autofocus: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18, 3, 18, 3),
                    child: TextField(
                      onChanged: (String newImage) {
                        newWorkoutImageUrl = newImage;
                      },
                      decoration: InputDecoration(
                        labelText: '이미지',
                        border: InputBorder.none,
                        filled: true,
                      ),
                      autofocus: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18, 3, 18, 3),
                    child: TextField(
                      onChanged: (String newAudio) {
                        newWorkoutAudioUrl = newAudio;
                      },
                      decoration: InputDecoration(
                        labelText: 'mp3',
                        border: InputBorder.none,
                        filled: true,
                      ),
                      autofocus: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18, 3, 18, 3),
                    child: TextField(
                      onChanged: (String newMinutes) {
                        newWorkoutMinutes = int.parse(newMinutes);
                      },
                      decoration: InputDecoration(
                        labelText: '목표시간',
                        border: InputBorder.none,
                        filled: true,
                      ),
                      autofocus: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18, 3, 18, 3),
                    child: TextField(
                      onChanged: (String newKcal) {
                        newWorkoutKcal = int.parse(newKcal);
                      },
                      decoration: InputDecoration(
                        labelText: '칼로리',
                        border: InputBorder.none,
                        filled: true,
                      ),
                      autofocus: true,
                    ),
                  ),
                  SizedBox(height: 18),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              color: Theme.of(context).primaryColor,
            ),
            height: 50,
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                // addWorkoutCallback(
                //   Workout(
                //       name: newWorkoutTitle ?? 'noName',
                //       minutes: newWorkoutMinutes,
                //       imageName: newWorkoutImageUrl ?? '',
                //       audioName: newWorkoutAudioUrl ?? '',
                //       kcal: newWorkoutKcal),
                // );
                Provider.of<WorkoutProvider>(context, listen: false).addWorkout(
                  Workout(
                      name: newWorkoutTitle ?? 'noName',
                      minutes: newWorkoutMinutes,
                      imageName: newWorkoutImageUrl ?? '',
                      audioName: newWorkoutAudioUrl ?? '',
                      kcal: newWorkoutKcal),
                );
                Navigator.pop(context);
              },
              child: Text(
                '추가',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
