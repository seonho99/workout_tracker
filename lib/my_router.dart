import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker/workout_guide_page.dart';
import 'package:workout_tracker/workout_home_page.dart';
import 'package:workout_tracker/workout_list_page.dart';
import 'landing_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return LandingPage();
      },
    ),
    GoRoute(
      path: '/workout_home',
      builder: (context, state) {
        return WorkoutHomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'workout_list/:group_index',
          builder: (context, state) {
            String? groupIndexString = state.pathParameters['group_index'];
            final groupIndex = int.parse(groupIndexString!);
            return WorkoutListPage(groupIndex: groupIndex);
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'workout_guide/:workouts_index',
              builder: (context, state) {
                String? workoutsIndexString = state.pathParameters['workouts_index'];
                final workoutsIndex = int.parse(workoutsIndexString!);

                String? groupIndexString= state.pathParameters['group_index'];
                final groupIndex = int.parse(groupIndexString!);

                return WorkoutGuidePage(
                    workoutsIndex: workoutsIndex,
                groupIndex: groupIndex);

              },
            ),
          ],
        ),
      ],
    ),
  ],
);
