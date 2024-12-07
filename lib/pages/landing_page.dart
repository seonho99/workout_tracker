import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/runner.png'),
              fit: BoxFit.cover,
              opacity: 0.2,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.white60,
                  child: Text(
                    '남들이 그만둘 때, 난 계속한다',
                    style: TextStyle(fontSize: 23),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        '환영합니다',
                        style: TextStyle(fontSize: 35, fontFamily: 'Jua'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(30),
                      child: ElevatedButton(onPressed: (){
                        context.go('/workout_home');
                      }, child: Text(
                        'Start',style: TextStyle(fontSize: 35),
                      ),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
