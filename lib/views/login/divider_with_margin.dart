import 'package:flutter/material.dart';

class DividerWithMargin extends StatelessWidget {
  const DividerWithMargin({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 44.0,
        ),
        Divider(),
        SizedBox(
          height: 44.0,
        ),
      ],
    );
  }
}
