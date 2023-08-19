import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kof_auth/constants.dart';
import 'package:kof_auth/screens/dashboard_screen.dart';
import 'package:kof_auth/services/firebase.dart';

class BottomWidget extends StatefulWidget {
  String textButton, textOfDivider, bottomText1, bottomText2;
  VoidCallback callback;
  VoidCallback callback2;
  BottomWidget(
      {required this.textButton,
      required this.textOfDivider,
      required this.bottomText1,
      required this.bottomText2,
      required this.callback,
      required this.callback2,
      super.key});

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.getScreenSize(context).height * 0.35,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          TextButton(
            onPressed: widget.callback,
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minimumSize: Size(Constants.getScreenSize(context).width, 60),
                foregroundColor: Colors.white),
            child: Text(
              widget.textButton,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Constants.mySpacer(1),
          Row(
            children: [
              const Expanded(
                  child: Divider(
                color: Colors.black38,
              )),
              const SizedBox(
                width: 20,
              ),
              Text(widget.textOfDivider),
              const SizedBox(
                width: 20,
              ),
              const Expanded(
                  child: Divider(
                color: Colors.black38,
              ))
            ],
          ),
          Constants.mySpacer(2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              getCircleLogo("assets/facebook.png"),
              GestureDetector(
                  onTap: () {
                    _showLoadingAlert(context);
                    FirebaseService firebaseService = FirebaseService();
                    firebaseService
                        .signInWithGoogle()
                        .then((userCredential) => {verify(userCredential)});
                  },
                  child: getCircleLogo("assets/google.png"))
            ],
          ),
          Constants.mySpacer(2),
          GestureDetector(
            onTap: widget.callback2,
            child: RichText(
                text: TextSpan(children: [
              TextSpan(text: widget.bottomText1),
              TextSpan(
                  text: " ${widget.bottomText2}",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary))
            ], style: const TextStyle(color: Colors.black38))),
          )
        ],
      ),
    );
  }

  getCircleLogo(String path) {
    return Container(
      height: 60,
      width: 60,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(60)),
      child: Image(image: AssetImage(path)),
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

  verify(UserCredential userCredential) {
    Navigator.pop(context);
    if (userCredential.user == null) {
      Constants.showAlert(
          context, "Erreur survenue lors de l'authentification");
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()));
    }
  }
}
