import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/bloc/workout_bloc/workout_bloc.dart';
import 'package:workout_tracker/data/bloc/workout_bloc/workout_event.dart';
import 'package:workout_tracker/pages/bloc_state/workout_day_selector.dart';

import '../../data/bloc/workout_bloc/workout_state.dart';
import '../../data/workout.dart';

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
          BlocBuilder<WorkoutBloc,WorkoutState>(
            builder: (context,state) {
              Workout workout = state.workouts[index];
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
                    '${workout.minutes} 분',
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<WorkoutBloc>().add(DeleteWorkout(index));
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
