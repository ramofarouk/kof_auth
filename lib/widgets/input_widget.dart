import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {
  TextEditingController controller;
  String hintText, errorText;
  MyInput(
      {required this.controller,
      required this.hintText,
      required this.errorText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        return value!.isEmpty ? errorText : null;
      },
      decoration:
          InputDecoration(border: OutlineInputBorder(), hintText: hintText),
    );
  }
}
