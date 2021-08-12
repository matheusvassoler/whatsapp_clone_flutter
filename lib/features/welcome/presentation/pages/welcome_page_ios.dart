import 'package:flutter/cupertino.dart';
import 'package:whatsapp/core/app_colors.dart';
import 'package:whatsapp/core/strings.dart';

class WelcomePageIos extends StatelessWidget {
  const WelcomePageIos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    //color: Color(AppColors.blue),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Image(
                            width: 260,
                            height: 260,
                            image: AssetImage(
                                'images/whatsapp_welcome_screen_icon.png'),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 100.0, bottom: 20.0),
                            child: Text(
                              Strings.welcomePageTitle,
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                text: Strings.welcomePageReadOur,
                                style: TextStyle(
                                    color: Color(AppColors.intermediateGray),
                                    height: 1.5),
                                children: [
                                  TextSpan(
                                    text: Strings.welcomePagePrivacyPolicy,
                                    style:
                                        TextStyle(color: Color(AppColors.blue)),
                                  ),
                                  TextSpan(
                                    text: Strings.welcomePageAgreeIos,
                                  ),
                                  TextSpan(
                                    text: Strings.welcomePageTermsOfService,
                                    style:
                                        TextStyle(color: Color(AppColors.blue)),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Text(
                                Strings.welcomePageAgreeAndContinueIos,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color(AppColors.blue),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                Strings.welcomePageFromFacebook,
                style: TextStyle(color: Color(AppColors.intermediateGray)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 25.0),
                child: Image(
                  image: AssetImage('images/wordmarkupdate.png'),
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
