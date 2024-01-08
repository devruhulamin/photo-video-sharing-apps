import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/constant/firebase_field_name.dart';
import 'package:instagram_clone/state/post/typedefs/post_id.dart';
import 'package:instagram_clone/state/post/typedefs/user_id.dart';

@immutable
class Like extends MapView<String, String> {
  Like({
    required PostId postId,
    required UserId likedBy,
    required DateTime dateTime,
  }) : super({
          FirebaseFieldName.postId: postId,
          FirebaseFieldName.userId: likedBy,
          FirebaseFieldName.date: dateTime.toIso8601String(),
        });
}
