import 'package:flutter/material.dart';
import 'package:whatsapp/components/check_already_has_account.dart';
import 'package:whatsapp/components/custom_button.dart';
import 'package:whatsapp/components/custom_input_data.dart';
import 'package:whatsapp/components/custom_password_input_data.dart';
import 'package:whatsapp/components/text_field_container.dart';
import 'package:whatsapp/screens/home.dart';
import 'package:whatsapp/screens/login.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("images/b107f44d7bb7bf8abcf58afd9df500de.png"),
        fit: BoxFit.cover,
      )),
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Text(
                "Criar conta",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            TextFieldContainer(
              CustomInputData(
                "E-mail",
                Icons.person,
              ),
            ),
            TextFieldContainer(
              CustomPasswordInputData("Senha", Icons.lock),
            ),
            CustomButton(
              "Criar conta",
              () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              ),
            ),
            CheckAlreadyHasAccount(false, () {
              Navigator.pop(context);
            })
          ],
        ),
      ),
    ));
  }
}
