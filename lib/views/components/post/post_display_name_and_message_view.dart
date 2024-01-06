import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/post/models/post.dart';
import 'package:instagram_clone/state/user_info/providers/user_info_model_provider.dart';
import 'package:instagram_clone/views/components/animations/small_error_animaion_view.dart';
import 'package:instagram_clone/views/components/post/rich_two_part_text.dart';

class PostDisplayNameAndMessageView extends ConsumerWidget {
  final Post post;
  const PostDisplayNameAndMessageView({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoProvider = ref.watch(userInfoModelProvider(post.userId));
    return userInfoProvider.when(
      data: (userinfo) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: RichTwoPartText(
            leftPart: userinfo.displayName,
            rightPart: post.message,
          ),
        );
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
