import 'package:flutter/material.dart';

class AnimatedIconWidget extends StatefulWidget {
  final IconData icon;
  final double size;
  final Color color;
  const AnimatedIconWidget({
    Key? key,
    required this.icon,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  State<AnimatedIconWidget> createState() => _AnimatedIconWidgetState();
}

class _AnimatedIconWidgetState extends State<AnimatedIconWidget>   with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    final Animation<double> curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutSine,
    );
    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 40.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 40.0, end: -20.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -20.0, end: 7.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 7.0, end: -3.5), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -3.5, end: 1.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 1),
    ]).animate(curvedAnimation);

    _animation.addListener(() {
      if(_animation.status==AnimationStatus.completed){
        _controller.reverse();
      }else if(_animation.status==AnimationStatus.dismissed){
        _controller.forward();
      }
    });
    _controller.forward();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value * 0.0174533, // 1도 = 0.0174533 라디안
          child: Icon(
            widget.icon,
            size: widget.size,
            color: widget.color,
          ),
        );
      },
    );
  }
}