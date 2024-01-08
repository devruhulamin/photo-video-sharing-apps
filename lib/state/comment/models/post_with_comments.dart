import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/comment/models/comment_mode.dart';
import 'package:instagram_clone/state/post/models/post.dart';

@immutable
class PostWithComments {
  final Post post;
  final Iterable<CommentModel> comments;

  const PostWithComments({required this.post, required this.comments});

  @override
  operator ==(covariant PostWithComments other) =>
      post == other.post &&
      const IterableEquality().equals(comments, other.comments);

  @override
  int get hashCode => Object.hashAll([post, comments]);
}
