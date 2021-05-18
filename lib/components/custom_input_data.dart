import 'package:flutter/material.dart';

class CustomInputData extends StatelessWidget {
  final String hintText;
  final IconData icon;

  CustomInputData(this.hintText, this.icon);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          icon: Icon(icon), hintText: hintText, border: InputBorder.none),
    );
  }
}