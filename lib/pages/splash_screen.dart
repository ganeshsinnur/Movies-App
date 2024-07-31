import 'dart:async';

import 'package:alibaba/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../widgets/bottom_navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 2000), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>bottomNavbar()));
    });
    // Timer(Duration(seconds: 3), )//
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        "assets/animations/squid_game_animation.json",
      ),
    );
  }
}
