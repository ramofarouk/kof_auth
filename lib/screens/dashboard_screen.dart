import 'package:flutter/material.dart';
import 'package:kof_auth/services/firebase.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Tableau de bord"),
            GestureDetector(
              child: TextButton(
                  onPressed: () {
                    FirebaseService service = FirebaseService();
                    service.signOut(context);
                  },
                  child: const Text("Déconnexion")),
            )
          ],
        ),
      ),
    );
  }
}
