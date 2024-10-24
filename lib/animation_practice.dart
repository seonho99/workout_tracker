import 'package:flutter/material.dart';

class AnimationPractice extends StatefulWidget {
  const AnimationPractice({super.key});

  @override
  State<AnimationPractice> createState() => _AnimationPracticeState();
}

class _AnimationPracticeState extends State<AnimationPractice> {
double _scale = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedScale(
            scale: _scale,
            duration: Duration(seconds: 1),
        child: FlutterLogo(size: 75),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            setState(() {
                  _scale=_scale==1.0?2.0:1.0;
            });
      },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
