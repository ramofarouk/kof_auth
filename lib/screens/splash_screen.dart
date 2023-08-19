import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kof_auth/screens/dashboard_screen.dart';

import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 4000), () {
      checkUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 150,
        child: SpinKitFadingCube(
          color: Theme.of(context).colorScheme.primary,
          size: 50.0,
        ),
      ),
      body: const Center(
        child: CircleAvatar(
            radius: 80,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Image(image: AssetImage("assets/logo.png")),
            )),
      ),
    );
  }

  void checkUser() {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const OnBoardingScreen()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()));
    }
  }
}
