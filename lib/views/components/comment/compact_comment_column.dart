import 'package:flutter/material.dart';
import 'package:instagram_clone/state/comment/models/comment_mode.dart';
import 'package:instagram_clone/views/components/comment/compact_commnet_tile.dart';

class CompactCommentColumn extends StatelessWidget {
  final Iterable<CommentModel> comments;
  const CompactCommentColumn({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: comments
            .map((comment) => CompactCommentTile(comment: comment))
            .toList(),
      ),
    );
  }
}
