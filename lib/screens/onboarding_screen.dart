import 'package:flutter/material.dart';
import 'package:kof_auth/screens/login_screen.dart';
import 'package:kof_auth/screens/register_screen.dart';
import 'package:kof_auth/widgets/bottom_widget.dart';

import '../constants.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomWidget(
          textButton: "Créer un compte",
          textOfDivider: "Ou s'inscrire avec",
          bottomText1: "Avez-vous déjà un compte?",
          bottomText2: "Se connecter",
          callback: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterScreen()));
          },
          callback2: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          }),
      body: Container(
        height: Constants.getScreenSize(context).height * 0.65,
        padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: Constants.getScreenSize(context).height * 0.07),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bienvenue sur KOFAUTH",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            Text(
              "KOFAUTH est une application permettant à tous les "
              "développeurs d'apprendre rapidement du Flutter en "
              "un temps record. N'hésitez pas à poser des questions.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}
