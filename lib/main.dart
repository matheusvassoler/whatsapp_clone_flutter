import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/features/welcome/presentation/pages/welcome_page_android.dart';
import 'package:whatsapp/features/welcome/presentation/pages/welcome_page_ios.dart';

void main() {
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
