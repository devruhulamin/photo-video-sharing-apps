import 'package:flutter/foundation.dart' show immutable, VoidCallback;
import 'package:instagram_clone/views/components/rich_text/base_text.dart';

@immutable
class LinkText extends BaseText {
  final VoidCallback ontapped;

  const LinkText(
      {required this.ontapped, required super.text, required super.style});
}
