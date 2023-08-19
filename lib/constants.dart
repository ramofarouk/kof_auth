import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Constants {
  static getScreenSize(context) {
    return MediaQuery.sizeOf(context);
  }

  static mySpacer(double count) {
    return SizedBox(
      height: 10 * count,
    );
  }

  static showAlert(context, String error) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(error),
            ));
  }
}
