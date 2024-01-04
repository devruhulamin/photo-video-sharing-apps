import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/state/constant/firebase_field_name.dart';
import 'package:instagram_clone/state/post/typedefs/post_id.dart';
import 'package:instagram_clone/state/post/typedefs/user_id.dart';

@immutable
class CommentPayload extends MapView<String, dynamic> {
  CommentPayload({
    required UserId userId,
    required PostId postId,
    required String comment,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.postId: postId,
          FirebaseFieldName.comment: comment,
          FirebaseFieldName.createdAt: FieldValue.serverTimestamp(),
        });
}
