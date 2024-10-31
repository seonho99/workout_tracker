import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker/frame_page.dart';
import 'package:workout_tracker/login_page.dart';
import 'package:workout_tracker/profile_page.dart';
import 'package:workout_tracker/registration_page.dart';
import 'package:workout_tracker/reset_password_page.dart';
import 'package:workout_tracker/settings_page.dart';
import 'package:workout_tracker/workout_guide_page.dart';
import 'package:workout_tracker/workout_home_page.dart';
import 'package:workout_tracker/workout_list_page.dart';
import 'landing_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _homeTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'homeTab');
final GlobalKey<NavigatorState> _settingsTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'settingsTab');

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => LandingPage(),
    ),
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state, navigationShell) {
        return FramePage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeTabNavigatorKey,
          routes: [
            GoRoute(
              path: '/workout_home',
              builder: (context, state) {
                return WorkoutHomePage();
              },
              routes: <RouteBase>[
                GoRoute(
                  path: 'workout_list/:group_index',
                  builder: (context, state) {
                    String? groupIndexString =
                        state.pathParameters['group_index'];
                    final groupIndex = int.parse(groupIndexString!);
                    return WorkoutListPage(groupIndex: groupIndex);
                  },
                  routes: <RouteBase>[
                    GoRoute(
                      path: 'workout_guide/:workouts_index',
                      builder: (context, state) {
                        String? workoutsIndexString =
                            state.pathParameters['workouts_index'];
                        final workoutsIndex = int.parse(workoutsIndexString!);

                        String? groupIndexString =
                            state.pathParameters['group_index'];
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
        ),
        StatefulShellBranch(
          navigatorKey: _settingsTabNavigatorKey,
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) {
                return SettingsPage();
              },
              routes: [
                GoRoute(
                    path: 'profile',
                builder: (context, state){
                  return ProfilePage();
                },),
                GoRoute(
                  path: 'login',
                  builder: (context, state) {
                    return LoginPage();
                  },
                  routes: [
                    GoRoute(
                      path: 'registration',
                      builder: (context, state) {
                        return RegistrationPage();
                      },
                    ),
                    GoRoute(
                        path: 'reset_password',
                      builder: (context, state){
                          return ResetPasswordPage();
                      }
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
  redirect: (context, state){
    User? user = FirebaseAuth.instance.currentUser;
    if((user == null ) &&
        (state.uri.path != '/settings/login/registration' &&
        state.uri.path != '/settings/login/reset_password' &&
        state.uri.path != '/')){
      return '/settings/login';
    }
    if(user != null && (state.uri.path == '/settings/login' || state.uri.path == '/settings/login/registration')){
      return '/settings';
    }
  }
);
