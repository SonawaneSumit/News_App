// ignore_for_file: unused_field, camel_case_types

import 'dart:async';

import 'package:new_york_news/screen/HomeScreen/bottomNavbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen>
    with TickerProviderStateMixin {
  late Animation<double> _heartbeatAnimation;
  late AnimationController _controller;

  double _rotation = 0.0;
  Timer? _timer;
  Timer? navigation;

  @override
  void initState() {
    super.initState();
    _startRotation();
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Heartbeat duration
      vsync: this,
    )..repeat(reverse: true);

    _heartbeatAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    navigation = Timer(const Duration(seconds: 2), () {
      Get.offAll(() => const dashboard());
    });
  }

  void _startRotation() {
    _timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      setState(() {
        _rotation += 0.05;
        if (_rotation >= 360) {
          _rotation = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    navigation?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff3b444b),
                Color(0xffb9e2f5),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60,
                  child: ScaleTransition(
                    scale: _heartbeatAnimation,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/NYT_Logo.png",
                        height: 200,
                        width: 150,
                      ),
                      // AnimatedBuilder(
                      //   animation: _controller,
                      //   builder: (context, child) {
                      //     return Transform(
                      //       transform: Matrix4.rotationY(_rotation),
                      //       alignment: Alignment.center,
                      //       child: child,
                      //     );
                      //   },
                      //   child: Image.asset(
                      //     "assets/NYT_Logo.png",
                      //     height: 200,
                      //     width: 150,
                      //   ),
                      // ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
