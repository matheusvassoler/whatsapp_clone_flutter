import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  "Bem-vindo(a) ao WhatsApp",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Flexible(
                child: Image(
                  image: AssetImage("images/whatsapp_welcome_screen_icon.png"),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                        "Leia a nossa Política de Privacidade. Toque em CONCORDAR E CONTINUAR para aceitar os Termos de Serviço."),
                    ElevatedButton(
                      child: Text(
                        "CONCORDAR E CONTINUAR",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(
                            Theme.of(context).accentColor.value,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Text("From facebook")
            ],
          ),
        ),
      ),
    );
  }
}
