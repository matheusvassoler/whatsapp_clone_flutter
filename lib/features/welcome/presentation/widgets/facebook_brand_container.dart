import 'package:flutter/widgets.dart';
import 'package:whatsapp/core/app_colors.dart';
import 'package:whatsapp/core/strings.dart';

class FacebookBrandContainer extends StatelessWidget {
  const FacebookBrandContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          Strings.welcomePageFromFacebook,
          style:
          TextStyle(color: Color(AppColors.intermediateGray)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 25.0),
          child: Image(
            image: AssetImage('images/wordmarkupdate.png'),
            width: 90,
          ),
        )
      ],
    );
  }
}
