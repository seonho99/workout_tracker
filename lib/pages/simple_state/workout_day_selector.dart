import 'package:flutter/material.dart';
import 'package:workout_tracker/data/days_of_week.dart';

class WorkoutDaySelector extends StatefulWidget {
  final Function(List<bool>) updateWorkoutDays;
  final Set<DaysOfWeek> workoutDays;
  const WorkoutDaySelector({super.key,required this.updateWorkoutDays, required this.workoutDays});

  @override
  State<WorkoutDaySelector> createState() => _WorkoutDaySelectorState();
}

class _WorkoutDaySelectorState extends State<WorkoutDaySelector> {
  List<bool> isSelected = List.filled(7, false);
  Set<DaysOfWeek> selectedWorkoutDays={};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSelected = changeWorkoutDaysToIsSelected();
  }

  void updateIsSelected(int index){
    isSelected[index] = !isSelected[index];
    widget.updateWorkoutDays(isSelected);
  }

  List<bool> changeWorkoutDaysToIsSelected(){
    List<bool> isSelected = List.filled(7, false);
    for(var week in widget.workoutDays){
      isSelected[week.index] = true;
    }
    return isSelected;
  }



  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      onPressed: (index) {
        setState(() {
          updateIsSelected(index);
        });
      },
      children: [for (var item in DaysOfWeek.values) Text(item.kor)],
      isSelected: isSelected,
    );
  }
}
