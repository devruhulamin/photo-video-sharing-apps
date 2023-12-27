import 'package:flutter/material.dart'
    show immutable, TextStyle, VoidCallback, Colors, TextDecoration;
import 'package:instagram_clone/views/components/rich_text/link_text.dart';

@immutable
class BaseText {
  final String text;
  final TextStyle? style;

  const BaseText({required this.text, required this.style});

  factory BaseText.plain(
      {required String txt, TextStyle? style = const TextStyle()}) {
    return BaseText(text: txt, style: style);
  }
  factory BaseText.link(
      {required String txt,
      TextStyle style = const TextStyle(
          color: Colors.blue, decoration: TextDecoration.underline),
      required VoidCallback ontapped}) {
    return LinkText(ontapped: ontapped, text: txt, style: style);
  }
}
