import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';
import 'package:workout_tracker/workout_home_page.dart';

class AuthBridge extends StatelessWidget {
  const AuthBridge({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){

          }
          return WorkoutHomePage();
        },
    );
  }
}
