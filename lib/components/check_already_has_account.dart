import 'package:flutter/material.dart';

class CheckAlreadyHasAccount extends StatelessWidget {
  final bool login;
  final Function onPress;

  CheckAlreadyHasAccount(this.login, this.onPress);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            login ? "Não possui uma conta? " : "Já possui uma conta? ",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            login ? "Criar conta" : "Entrar",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
