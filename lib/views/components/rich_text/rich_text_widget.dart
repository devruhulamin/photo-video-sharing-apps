import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/views/components/rich_text/base_text.dart';
import 'package:instagram_clone/views/components/rich_text/link_text.dart';

class RichTextWidget extends StatelessWidget {
  final Iterable<BaseText> basetext;
  final TextStyle? styleForAll;
  const RichTextWidget({super.key, required this.basetext, this.styleForAll});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      children: basetext.map((baseText) {
        if (baseText is LinkText) {
          return TextSpan(
            text: baseText.text,
            style: styleForAll?.merge(baseText.style),
            recognizer: TapGestureRecognizer()..onTap = baseText.ontapped,
          );
        } else {
          return TextSpan(
            text: baseText.text,
            style: styleForAll?.merge(baseText.style),
          );
        }
      }).toList(),
    ));
  }
}
