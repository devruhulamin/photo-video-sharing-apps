import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/likes/providers/likes_count_provider.dart';

import 'package:instagram_clone/state/reels/model/reels.dart';
import 'package:instagram_clone/views/components/animations/small_error_animaion_view.dart';

import 'package:instagram_clone/views/components/post/like_button.dart';
import 'package:instagram_clone/views/extensions/int_count.dart';
import 'package:instagram_clone/views/post_comment/post_comment_view.dart';

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
          Consumer(
            builder: (context, ref, child) {
              final likes = ref.watch(postLikesCountProvider(reels.reelId));

              return likes.when(
                data: (likes) {
                  return Text(likes.intToViewConvert());
                },
                error: (error, stackTrace) => const SmallErrorAnimationView(),
                loading: () => const CircularProgressIndicator(),
              );
            },
          ),
          if (reels.allowComments)
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PostCommentView(postId: reels.reelId),
                  ));
                },
                icon: const Icon(Icons.mode_comment_outlined))
        ],
      ),
    );
  }
}
