import 'package:flutter/material.dart';
import 'package:instagram_clone/views/components/reels/iccon_button_with_text.dart';

class ReelsActionButton extends StatelessWidget {
  const ReelsActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 250,
      child: Column(
        children: [
          IcconButtonWithText(
              onTap: () {}, icon: Icons.favorite_outline, iconLabel: '1.5k'),
          IcconButtonWithText(
              onTap: () {}, icon: Icons.comment_outlined, iconLabel: '765'),
          IcconButtonWithText(onTap: () {}, icon: Icons.delete, iconLabel: ''),
        ],
      ),
    );
  }
}
