import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/features/welcome/presentation/pages/welcome_page_android.dart';
import 'package:whatsapp/features/welcome/presentation/pages/welcome_page_ios.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(Whatsapp());
}

class Whatsapp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid) {
      return MaterialApp(
        theme: ThemeData(
          primaryColorDark: Color(0xFF075E54),
          primaryColor: Color(0xFF128C7E),
          accentColor: Color(0xFF25D366),
          indicatorColor: Colors.white,
        ),
        home: WelcomePageAndroid(),
      );
    } else {
      return CupertinoApp(
        theme: CupertinoThemeData(

        ),
        home: WelcomePageIos(),
      );
    }
  }
}
