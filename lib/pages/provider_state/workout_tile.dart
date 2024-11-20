import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/data/days_of_week.dart';
import 'package:workout_tracker/data/provider/workout_provider.dart';
import 'package:workout_tracker/pages/provider_state/workout_day_selector.dart';

class WorkoutTile extends StatelessWidget {
  final int index;


  const WorkoutTile({
    super.key,
    required this.index,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Consumer<WorkoutProvider>(
            builder: (context,workoutProvider, child) {
              var workout = workoutProvider.workouts[index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow,
                      image: DecorationImage(
                        image: NetworkImage(workout.imageName),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '${index + 1}.${workout.name}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Text(
                    '${workout.minutes}',
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<WorkoutProvider>(context,listen:false).deleteWorkout(index);
                    },
                    icon: Icon(Icons.delete_outline),
                  ),
                ],
              );
            }
          ),
          SizedBox(height:10),
          WorkoutDaySelector(
            workoutIndex: index,
          ),
        ],
      ),
    );
  }
}
