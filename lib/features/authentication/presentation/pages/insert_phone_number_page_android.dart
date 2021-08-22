import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/core/app_colors.dart';
import 'package:whatsapp/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:whatsapp/injection_contanier.dart';

class InsertPhoneNumberPageAndroid extends StatefulWidget {
  const InsertPhoneNumberPageAndroid({Key key}) : super(key: key);

  @override
  _InsertPhoneNumberPageAndroidState createState() =>
      _InsertPhoneNumberPageAndroidState();
}

class _InsertPhoneNumberPageAndroidState
    extends State<InsertPhoneNumberPageAndroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Insira seu número de telefone",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        actions: [
          IconButton(
            color: Color(AppColors.intermediateDarkGray),
            onPressed: () => {},
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      backgroundColor: Color(Colors.white.value),
      body: buildBody(context),
    );
  }

  BlocProvider<AuthenticationCubit> buildBody(context) {
    final _mediaQuery = MediaQuery.of(context);
    final _countryController = TextEditingController()..text = "Brasil";
    final _ddiController = TextEditingController();
    final _phoneNumberController = TextEditingController();

    return BlocProvider(
      create: (_) => getIt<AuthenticationCubit>(),
      child: Builder(builder: (BuildContext context) {
        return SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
              child: Column(
                children: [
                  Text(
                    "O WhatsApp enviará uma mensagem SMS para confirmar seu número de telefone. Qual é meu número?",
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 1.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: SizedBox(
                      width: _mediaQuery.orientation == Orientation.portrait
                          ? _mediaQuery.size.width * 0.65
                          : _mediaQuery.size.width * 0.4,
                      child: TextField(
                        showCursor: false,
                        controller: _countryController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.only(bottom: 5.0),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              child: Icon(
                                Icons.add,
                                color: Color(AppColors.intermediateGray),
                                size: 15,
                              ),
                              top: 3,
                              left: -2,
                            ),
                            SizedBox(
                              width: _mediaQuery.orientation ==
                                      Orientation.portrait
                                  ? _mediaQuery.size.width * 0.18
                                  : _mediaQuery.size.width * 0.10,
                              child: TextField(
                                controller: _ddiController,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.only(left: 30.0, bottom: 5.0),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2.0,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        SizedBox(
                          width: _mediaQuery.orientation == Orientation.portrait
                              ? _mediaQuery.size.width * 0.43
                              : _mediaQuery.size.width * 0.28,
                          child: TextField(
                            controller: _phoneNumberController,
                            decoration: InputDecoration(
                              hintText: "seu número",
                              isDense: true,
                              contentPadding: EdgeInsets.only(bottom: 5.0),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Sujeita a cobranças de tarifas de SMS de sua operadora",
                      style: TextStyle(
                          color: Color(AppColors.intermediateDarkGray)),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 35.0),
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              final ddi = _ddiController.text;
                              final phoneNumber = _phoneNumberController.text;
                              context
                                  .read<AuthenticationCubit>()
                                  .sendSmsCode(ddi, phoneNumber);
                            },
                            child: Text(
                              "Avançar".toUpperCase(),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color(
                                  Theme.of(context).accentColor.value,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
