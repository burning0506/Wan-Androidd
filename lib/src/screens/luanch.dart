import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> with TickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..addStatusListener(_animationStatusListener)
      ..forward();

    _animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero
    ).animate(_controller);

  }

  @override
  Widget build(BuildContext context) {
    final Size winSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        SlideTransition(
          position: _animation,
          child: const Center(
              child: Icon(
            Icons.android,
            size: 150,
            color: Colors.teal,
          )),
        ),
          Positioned(
              top: winSize.height / 1.6,
              child: ScaleTransition(
                scale: CurvedAnimation(parent: _controller, curve: Curves.linear),
                child: const Text(
                  'Wan Android',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                          color: Colors.teal,
                          offset: Offset(5, 5),
                          blurRadius: 10),
                    ],
                  ),
                ),
              ),
        ),
        Positioned(
            bottom: 10,
            child: Column(
              children: const [
                Text(
                  'Power by Burning',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  '2022 version 1.0.1',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ))
      ],
    ));
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      Future.delayed(const Duration(milliseconds: 200), (){
        Navigator.popAndPushNamed(context, '/main');
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}
