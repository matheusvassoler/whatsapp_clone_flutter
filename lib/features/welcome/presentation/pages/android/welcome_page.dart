import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp/core/app_colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Text(
                          "Bem-vindo(a) ao WhatsApp",
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Image(
                          width: 260,
                          height: 260,
                          image: AssetImage(
                              "images/whatsapp_welcome_screen_icon.png"),
                        ),
                      ),
                      Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Leia nossa ',
                              style: TextStyle(
                                  color: Color(AppColors.intermediateGray)),
                              children: [
                                TextSpan(
                                  text: 'Política de Privacidade. ',
                                  style:
                                      TextStyle(color: Color(AppColors.blue)),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      final String url =
                                          'https://www.whatsapp.com/legal/privacy-policy';
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                ),
                                TextSpan(
                                  text:
                                      'Toque em CONCORDAR E CONTINUAR para aceitar os ',
                                ),
                                TextSpan(
                                  text: 'Termos de Serviço.',
                                  style:
                                      TextStyle(color: Color(AppColors.blue)),
                                  recognizer: TapGestureRecognizer()..onTap = () async {
                                    final String url =
                                        'https://www.whatsapp.com/legal/terms-of-service';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                }
                                )
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: ElevatedButton(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 12.0),
                                child: Text(
                                  "CONCORDAR E CONTINUAR",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color(
                                    Theme.of(context).accentColor.value,
                                  ),
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Text(
                "from",
                style: TextStyle(color: Color(AppColors.intermediateGray)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 25.0),
                child: Image(
                  image: AssetImage("images/wordmarkupdate.png"),
                  width: 90,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
