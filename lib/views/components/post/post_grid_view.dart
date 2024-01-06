import 'package:flutter/material.dart';
import 'package:instagram_clone/state/post/models/post.dart';
import 'package:instagram_clone/views/components/post/post_thumbnail_view.dart';
import 'package:instagram_clone/views/post_comment/post_comment_view.dart';

class PostGridView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostGridView({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);
        return PostThumbnailView(
          post: post,
          ontapped: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PostCommentView(postId: post.postId),
            ));
            //TODO Navigate to post details Views
          },
        );
      },
    );
  }
}
