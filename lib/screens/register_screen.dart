import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kof_auth/screens/login_screen.dart';
import 'package:kof_auth/widgets/bottom_widget.dart';
import 'package:kof_auth/widgets/input_widget.dart';

import '../constants.dart';
import '../services/firebase.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> keyForm = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomWidget(
          textButton: "Valider",
          textOfDivider: "Ou s'inscrire avec",
          bottomText1: "Avez-vous déjà un compte?",
          bottomText2: "Se connecter",
          callback: () {
            if (keyForm.currentState!.validate()) {
              _showLoadingAlert(context);
              FirebaseService firebaseService = FirebaseService();
              firebaseService.signUp(
                  context, _emailController.text, _passwordController.text);
            }
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Créer un compte",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Inscrivez-vous dès maintenant sur KOFAUTH pour bénéficier des avantages de la communauté de développeurs.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            Constants.mySpacer(2),
            Form(
                key: keyForm,
                child: Column(
                  children: [
                    MyInput(
                      controller: _emailController,
                      hintText: "Adresse mail",
                      errorText: "L'adresse mail est obligatoire",
                    ),
                    Constants.mySpacer(1),
                    MyInput(
                      controller: _passwordController,
                      hintText: "Mot de passe",
                      errorText: "Le mot de passe est obligatoire",
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  _showLoadingAlert(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                content: SizedBox(
                  height: 100,
                  child: SpinKitPulsingGrid(
                    color: Theme.of(context).colorScheme.primary,
                    size: 50.0,
                  ),
                ),
              ),
            ));
  }
}
