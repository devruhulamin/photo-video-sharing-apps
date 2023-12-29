import 'package:flutter/material.dart';
import 'package:instagram_clone/state/post/models/post.dart';

class PostThumbnailView extends StatelessWidget {
  final Post post;
  final VoidCallback ontapped;
  const PostThumbnailView(
      {super.key, required this.post, required this.ontapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontapped,
      child: Image.network(
        post.thumbnailUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
