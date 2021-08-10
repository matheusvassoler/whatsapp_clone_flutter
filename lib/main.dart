import 'package:flutter/material.dart';
import 'package:whatsapp/features/welcome/presentation/pages/android/welcome_page.dart';
import 'package:whatsapp/screens/chat_room.dart';
import 'package:whatsapp/screens/home.dart';
import 'package:whatsapp/screens/login.dart';

void main() {
  runApp(Whatsapp());
}

class Whatsapp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColorDark: Color(0xFF075E54),
        primaryColor: Color(0xFF128C7E),
        accentColor: Color(0xFF25D366),
        indicatorColor: Colors.white,
      ),
      home: WelcomePage(),
    );
  }
}
