import 'package:flutter/material.dart';
import 'package:whatsapp/screens/chat_room.dart';
import 'package:whatsapp/screens/home.dart';
import 'package:whatsapp/screens/login.dart';

import 'injection_container.dart';

void main() async {
  await init();
  runApp(Whatsapp());
}

class Whatsapp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF075E54),
        accentColor: Color(0xFF2CB864),
        indicatorColor: Colors.white,
      ),
      home: Login(),
    );
  }
}
