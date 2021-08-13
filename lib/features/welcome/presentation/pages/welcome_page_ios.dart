import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/core/app_colors.dart';
import 'package:whatsapp/core/strings.dart';
import 'package:whatsapp/features/welcome/presentation/blocs/external_link/external_link_cubit.dart';
import 'package:whatsapp/features/welcome/presentation/widgets/facebook_brand_container.dart';
import 'package:whatsapp/features/welcome/presentation/common-android-ios/welcome_page_constants.dart';

class WelcomePageIos extends StatelessWidget {
  const WelcomePageIos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: buildBody(context));
  }

  BlocProvider<ExternalLinkCubit> buildBody(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => ExternalLinkCubit(),
      child: Builder(
        builder: (BuildContext context) {
          return SafeArea(
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
                                padding: EdgeInsets.only(
                                    top: _size.height * 0.1, bottom: 20.0),
                                child: Text(
                                  Strings.welcomePageTitle,
                                  textAlign: TextAlign.center,
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
                                        color:
                                            Color(AppColors.intermediateGray),
                                        height: 1.5),
                                    children: [
                                      TextSpan(
                                        text: Strings.welcomePagePrivacyPolicy,
                                        style: TextStyle(
                                            color: Color(AppColors.blue)),
                                        recognizer:
                                            _createGestureToOpenExternalLinkOnTextSpan(
                                                context,
                                                WelcomePageConstants
                                                    .privacyPolicyLink),
                                      ),
                                      TextSpan(
                                        text: Strings.welcomePageAgreeIos,
                                      ),
                                      TextSpan(
                                        text: Strings.welcomePageTermsOfService,
                                        style: TextStyle(
                                            color: Color(AppColors.blue)),
                                        recognizer:
                                            _createGestureToOpenExternalLinkOnTextSpan(
                                                context,
                                                WelcomePageConstants
                                                    .termsOfServiceLink),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: _size.height * 0.05),
                                  child: GestureDetector(
                                    child: Text(
                                      Strings.welcomePageAgreeAndContinueIos,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Color(AppColors.blue),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onTap: () {
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
                  ),
                  FacebookBrandContainer(),
                ],
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
