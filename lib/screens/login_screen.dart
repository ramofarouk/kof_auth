import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kof_auth/services/firebase.dart';
import 'package:kof_auth/widgets/bottom_widget.dart';
import 'package:kof_auth/widgets/input_widget.dart';

import '../constants.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> keyForm = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomWidget(
          textButton: "Se connecter",
          textOfDivider: "Ou se connecter avec",
          bottomText1: "Vous n'avez pas de compte?",
          bottomText2: "S'inscrire",
          callback: () {
            if (keyForm.currentState!.validate()) {
              _showLoadingAlert(context);
              FirebaseService firebaseService = FirebaseService();
              firebaseService.signIn(
                  context, _emailController.text, _passwordController.text);
            }
          },
          callback2: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterScreen()));
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
              "Ravi de vous revoir",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Accéeder à votre compte KOFAUTH pour bénéficier des avantages de la communauté de développeurs.",
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
