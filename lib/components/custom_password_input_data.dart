import 'package:flutter/material.dart';

class CustomPasswordInputData extends StatelessWidget {
  final String hintText;
  final IconData icon;

  CustomPasswordInputData(this.hintText, this.icon);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Senha",
        icon: Icon(Icons.lock),
        border: InputBorder.none,
      ),
    );
  }
}