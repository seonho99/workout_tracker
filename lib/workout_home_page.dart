import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker/firebase_auth_service.dart';
import 'package:workout_tracker/landing_page.dart';
import 'package:workout_tracker/workout_manager.dart';
import 'workout.dart';
import 'dashboard_card.dart';

class WorkoutHomePage extends StatefulWidget {
  const WorkoutHomePage({super.key});

  @override
  State<WorkoutHomePage> createState() => _WorkoutHomePageState();
}

class _WorkoutHomePageState extends State<WorkoutHomePage> {
  final FirebaseAuthService auth = FirebaseAuthService();
  String? profileImageURL;
  late Future<int> monthlyCountFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    monthlyCountFuture=WorkoutManager.getMonthlyWorkoutCount();
    profileImageURL = auth.user?.photoURL;
  }

  @override
  void didUpdateWidget(covariant WorkoutHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    monthlyCountFuture=WorkoutManager.getMonthlyWorkoutCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Just Do It',
                            style: TextStyle(fontSize: 33),
                          ),
                          Text(
                            '간단하다. 흔들리면 그것은 지방이다.',
                            style: TextStyle(fontSize: 23),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      margin: EdgeInsets.only(left: 18),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: Colors.orange,
                        ),
                        shape: BoxShape.circle,
                        image:
                            DecorationImage(
                                image: profileImageURL != null
                                    ? NetworkImage(profileImageURL!)
                                : AssetImage('assets/me.jpg'),
                            fit: BoxFit.cover),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: DashboardCard(
                        icon: Icon(
                          Icons.fitness_center,
                          size: 33,
                          color: Colors.orange,
                        ),
                        title: Text(
                          'Monthly',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        info: FutureBuilder<int>(
                          future: monthlyCountFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final monthlyWorkoutCount = snapshot.data ?? 0;
                              return Text(
                                '$monthlyWorkoutCount회',
                                style: TextStyle(
                                    fontSize: 33, fontWeight: FontWeight.bold),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Expanded(
                            child: DashboardCard(
                              icon: Icon(
                                Icons.update,
                                size: 33,
                                color: Colors.orange,
                              ),
                              title: Text(
                                '오늘운동시간',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              info: Text(
                                '10분',
                                style: TextStyle(
                                    fontSize: 33, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: DashboardCard(
                              icon: Icon(
                                Icons.fitness_center,
                                size: 33,
                                color: Colors.orange,
                              ),
                              title: Text(
                                '소모칼로리',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              info: Text(
                                '100Kcal',
                                style: TextStyle(
                                    fontSize: 33, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 250,
                          child: GestureDetector(
                            onTap: () {
                              context.go('/workout_home/workout_list');
                            },
                            child: DashboardCard(
                              icon: Icon(
                                Icons.run_circle_outlined,
                                size: 33,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.orange,
                              customOnTap: () {
                                context.go('/workout_home/workout_list/0');
                              },
                              title: Text(
                                '그룹1',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              info: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          WorkoutManager.workoutGroups[0]
                                              .groupDescription,
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )),
                                  Expanded(
                                    child: Image.asset('assets/sample1.png'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: GestureDetector(
                            onTap: () {
                              context.go('/workout_home/workout_list');
                            },
                            child: DashboardCard(
                              icon: Icon(
                                Icons.run_circle_outlined,
                                size: 33,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.teal,
                              customOnTap: () {
                                context.go('/workout_home/workout_list/1');
                              },
                              title: Text(
                                '그룹2',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              info: Row(
                                children: [
                                  Flexible(
                                      child: Column(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          WorkoutManager.workoutGroups[1]
                                              .groupDescription,
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )),
                                  Expanded(
                                    child: Image.asset('assets/sample2.png'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: DashboardCard(
                  icon: Icon(
                    Icons.list,
                    size: 33,
                    color: Colors.orange,
                  ),
                  backgroundColor: Colors.black87,
                  customOnTap: () {
                    context.go(
                        '/workout_home/workout_list/${WorkoutManager.currentWorkoutGroupIndex}');
                  },
                  title: Text(
                    '운동 이어서 하기',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                  info: Text(
                    '당신의 몸은 해 낼 수 있다. 당신의 마음만 설득하면 된다.',
                    style: TextStyle(fontSize: 23, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
