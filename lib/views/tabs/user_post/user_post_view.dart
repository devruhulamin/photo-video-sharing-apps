import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/post/providers/user_post_provider.dart';
import 'package:instagram_clone/views/components/animations/empty_animation_with_text_view.dart';
import 'package:instagram_clone/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone/views/components/post/post_grid_view.dart';
import 'package:instagram_clone/views/constants/view_strings.dart';

class UserPostsView extends ConsumerWidget {
  const UserPostsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPost = ref.watch(userPostProvider);
    return RefreshIndicator(
      child: userPost.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyAnimationWithText(
                text: ViewStrings.youHaveNoPosts);
          } else {
            return PostGridView(posts: posts);
          }
        },
        error: (error, stackTrace) => const ErrorAnimationView(),
        loading: () => const LoadingAnimationView(),
      ),
      onRefresh: () {
        // ignore: unused_result
        ref.refresh(userPostProvider);
        return Future.delayed(const Duration(seconds: 1));
      },
    );
  }
}
