import 'package:flutter/material.dart';

import 'package:instagram_clone/state/reels/model/reels.dart';

import 'package:instagram_clone/views/components/post/like_button.dart';
import 'package:instagram_clone/views/components/reels/iccon_button_with_text.dart';

class ReelsActionButton extends StatelessWidget {
  final Reels reels;
  const ReelsActionButton({super.key, required this.reels});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 250,
      child: Column(
        children: [
          LikeButton(postId: reels.reelId),
          IcconButtonWithText(
              onTap: () {},
              icon: const Icon(Icons.comment_outlined),
              iconLabel: '0'),
        ],
      ),
    );
  }
}
