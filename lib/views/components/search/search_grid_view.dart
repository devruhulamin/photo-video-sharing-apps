import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/post/providers/post_with_match_search_term_provider.dart';
import 'package:instagram_clone/state/post/typedefs/search_term.dart';
import 'package:instagram_clone/views/components/animations/data_not_found_animation_view.dart';
import 'package:instagram_clone/views/components/animations/empty_animation_with_text_view.dart';
import 'package:instagram_clone/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone/views/components/post/post_grid_view.dart';
import 'package:instagram_clone/views/constants/view_strings.dart';

class SearchGridView extends ConsumerWidget {
  final SearchTerm searchTerm;
  const SearchGridView({super.key, required this.searchTerm});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const EmptyAnimationWithText(
          text: ViewStrings.enterYourSearchTerm);
    }
    final posts = ref.watch(postsBySearchTermProvider(searchTerm));
    return posts.when(
      data: (postData) {
        if (postData.isEmpty) {
          return const DataNotFoundAnimationView();
        }
        return PostGridView(posts: postData);
      },
      error: (error, stackTrace) => const ErrorAnimationView(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
