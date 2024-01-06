import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/comment/type_defs/comment_type.dart';
import 'package:instagram_clone/state/constant/firebase_field_name.dart';
import 'package:instagram_clone/state/post/typedefs/post_id.dart';
import 'package:instagram_clone/state/post/typedefs/user_id.dart';

@immutable
class CommentModel {
  final CommentId commentId;
  final UserId userId;
  final PostId postId;
  final DateTime createdAt;
  final String comment;
  CommentModel({required Map<String, dynamic> json, required String commentid})
      : commentId = commentid,
        userId = json[FirebaseFieldName.userId],
        postId = json[FirebaseFieldName.postId],
        createdAt = (json[FirebaseFieldName.createdAt] as Timestamp).toDate(),
        comment = json[FirebaseFieldName.comment];
  @override
  operator ==(covariant CommentModel other) =>
      identical(this, other) ||
      (runtimeType == other.runtimeType &&
          commentId == other.commentId &&
          postId == other.postId &&
          createdAt == other.createdAt);

  @override
  int get hashCode =>
      Object.hashAll([runtimeType, commentId, postId, createdAt, userId]);
}
