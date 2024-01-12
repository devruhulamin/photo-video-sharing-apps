import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/post/providers/all_post_provider.dart';
import 'package:instagram_clone/views/components/animations/empty_animation_with_text_view.dart';
import 'package:instagram_clone/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone/views/components/post/post_grid_view.dart';
import 'package:instagram_clone/views/constants/view_strings.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(allPostsProvider);
    return RefreshIndicator(
      onRefresh: () {
        ref.invalidate(allPostsProvider);
        return Future.delayed(const Duration(seconds: 1));
      },
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyAnimationWithText(
                text: ViewStrings.noPostsAvailable);
          }
          return PostGridView(posts: posts);
        },
        error: (error, stackTrace) => const ErrorAnimationView(),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
