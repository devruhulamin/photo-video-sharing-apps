import 'package:flutter/material.dart';

class IcconButtonWithText extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String iconLabel;
  const IcconButtonWithText(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.iconLabel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              icon,
              size: 40,
              color: Colors.white,
            )),
        Text(iconLabel)
      ],
    );
  }
}
