import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/core/app_colors.dart';
import 'package:whatsapp/core/strings.dart';
import 'package:whatsapp/features/welcome/presentation/blocs/external_link/external_link_cubit.dart';
import 'package:whatsapp/features/welcome/presentation/widgets/facebook_brand_container.dart';
import 'package:whatsapp/features/welcome/presentation/common-android-ios/welcome_page_constants.dart';

class WelcomePageAndroid extends StatelessWidget {
  const WelcomePageAndroid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Colors.white.value),
      body: buildBody(context),
    );
  }

  BlocProvider<ExternalLinkCubit> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => ExternalLinkCubit(),
      child: Builder(
        builder: (BuildContext context) {
          return BlocListener<ExternalLinkCubit, ExternalLinkState>(
            listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      Strings.welcomePageErrorMessageOpeningExternalLink)));
            },
            child: SafeArea(
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
                                Strings.welcomePageTitle,
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
                                    'images/whatsapp_welcome_screen_icon.png'),
                              ),
                            ),
                            Column(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: Strings.welcomePageReadOur,
                                    style: TextStyle(
                                        color:
                                            Color(AppColors.intermediateGray),
                                        height: 1.5),
                                    children: [
                                      TextSpan(
                                        text: Strings.welcomePagePrivacyPolicy,
                                        style: TextStyle(
                                            color: Color(AppColors.blueAndroid)),
                                        recognizer:
                                            _createGestureToOpenExternalLinkOnTextSpan(
                                                context,
                                                WelcomePageConstants
                                                    .privacyPolicyLink),
                                      ),
                                      TextSpan(
                                        text: Strings.welcomePageAgreeAndroid,
                                      ),
                                      TextSpan(
                                        text: Strings.welcomePageTermsOfService,
                                        style: TextStyle(
                                            color: Color(AppColors.blueAndroid)),
                                        recognizer:
                                            _createGestureToOpenExternalLinkOnTextSpan(
                                                context,
                                                WelcomePageConstants
                                                    .termsOfServiceLink),
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
                                        Strings
                                            .welcomePageAgreeAndContinueAndroid
                                            .toUpperCase(),
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
                                    onPressed: () {
                                      // TODO - To implement navigation to next screen
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    FacebookBrandContainer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  TapGestureRecognizer _createGestureToOpenExternalLinkOnTextSpan(
      BuildContext context, String link) {
    return TapGestureRecognizer()
      ..onTap = () async {
        context.read<ExternalLinkCubit>().openWebPage(link);
      };
  }
}
