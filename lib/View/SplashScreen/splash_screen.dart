
import 'package:flutter/material.dart';

import '../../ViewModel/Services/SplashServices/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    SplashServices().navigateToScreen(context);
    animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 2650));

    CurvedAnimation(parent: animationController, curve: Curves.bounceIn);
    animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);


    animationController
        .forward();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: animation.value,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Asset/Image/splash.jpg'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
