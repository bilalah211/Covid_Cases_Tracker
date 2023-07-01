import 'dart:async';

import 'package:covid_tracker_app/view/world_states.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late AnimationController controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this)..repeat();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4),(){
      Navigator.pushReplacement((context), MaterialPageRoute(builder: (context){
        return const WorldStates();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: controller,
                builder: (context,child)
                {
              return Transform.rotate(angle: controller.value * 2.0,
              child: child,);
            },
              child: Container(
                height: 200,
                width: 200,
                child: Center(
                  child: Image.asset('images/virus.png'),
                ),
              )),
            const SizedBox(height: 25,),
            const Align(
              child: Text('Covid-19\nTracker App',
                textAlign: TextAlign.center,
                style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),),
            )
          ],
        ),
      ),
    );
  }
}
