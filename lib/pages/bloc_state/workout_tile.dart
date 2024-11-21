import 'package:flutter/material.dart';
import 'package:workout_tracker/data/days_of_week.dart';
import 'package:workout_tracker/pages/bloc_state/workout_day_selector.dart';

class WorkoutTile extends StatelessWidget {
  final int index;
  final String name;
  final String image;
  final int minutes;
  final Set<DaysOfWeek> workoutDays;

  final Function(int) deleteWorkout;
  final Function(List<bool>) updateWorkoutDays;

  const WorkoutTile({
    super.key,
    required this.index,
    required this.name,
    required this.image,
    required this.minutes,
    required this.workoutDays,
    required this.deleteWorkout,
    required this.updateWorkoutDays,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.yellow,
                  image: DecorationImage(
                    image: NetworkImage('$image'),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '${index + 1}.$name',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Text(
                '$minutes 분',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
              IconButton(
                onPressed: () {
                  deleteWorkout(index);
                },
                icon: Icon(Icons.delete_outline),
              ),
            ],
          ),
          SizedBox(height:10),
          WorkoutDaySelector(
            workoutDays: workoutDays,
            updateWorkoutDays: updateWorkoutDays,
          ),
        ],
      ),
    );
  }
}
