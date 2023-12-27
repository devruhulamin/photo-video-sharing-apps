import 'package:flutter/material.dart';
import 'package:instagram_clone/views/components/rich_text/base_text.dart';
import 'package:instagram_clone/views/components/rich_text/rich_text_widget.dart';
import 'package:instagram_clone/views/constants/view_strings.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginViewSignupLinks extends StatelessWidget {
  const LoginViewSignupLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
        styleForAll:
            Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
        basetext: [
          BaseText.plain(txt: ViewStrings.dontHaveAnAccount),
          BaseText.plain(txt: ViewStrings.signUpOn),
          BaseText.link(
            txt: ViewStrings.facebook,
            ontapped: () {
              launchUrlString(ViewStrings.facebookSignupUrl);
            },
          ),
          BaseText.plain(txt: ViewStrings.orCreateAnAccountOn),
          BaseText.link(
            txt: ViewStrings.google,
            ontapped: () {
              launchUrlString(ViewStrings.googleSignupUrl);
            },
          ),
        ]);
  }
}
