import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker/my_router.dart';
import 'package:workout_tracker/main.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              color: Colors.yellowAccent,
              child: Text(
                '남들이 그만둘 때, 난 계속한다.',
                style: TextStyle(fontSize: 23),
              ),
            ),
            Image(
              image: AssetImage('assets/runner.png'),
            ),
            Text(
              '환영합니다.',
              style: TextStyle(fontSize: 35),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/workout_home');
              },
              child: const Text(
                'START',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
