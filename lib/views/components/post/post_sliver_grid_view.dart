import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/post/models/post.dart';
import 'package:instagram_clone/views/components/post/post_thumbnail_view.dart';
import 'package:instagram_clone/views/post_details/post_details.dart';

class PostSliverGridView extends ConsumerWidget {
  final Iterable<Post> posts;
  const PostSliverGridView({super.key, required this.posts});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverGrid.builder(
      itemCount: posts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);
        return PostThumbnailView(
          post: post,
          ontapped: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PostDetailsView(post: post),
            ));
          },
        );
      },
    );
  }
}
