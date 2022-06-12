import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ynov_meteo/views/CitiesManagement.dart';
import 'package:page_transition/page_transition.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/logo_icon.png',
      nextScreen: CitiesManagement(title: ' '),
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.bottomToTop,
      backgroundColor: Color.fromARGB(255, 144, 168, 253),
    );
  }
}
