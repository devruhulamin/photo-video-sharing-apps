import 'dart:collection';

import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/constant/firebase_field_name.dart';
import 'package:instagram_clone/state/post/typedefs/user_id.dart';

@immutable
class UserInfoMode extends MapView<String, dynamic> {
  final UserId userId;
  final String displayName;
  final String? email;

  UserInfoMode(
      {required this.userId, required this.displayName, required this.email})
      : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email,
        });

  UserInfoMode.fromJson(
      {required Map<String, dynamic> json, required UserId userId})
      : this(
            userId: json[FirebaseFieldName.userId],
            displayName: json[FirebaseFieldName.displayName] ?? '',
            email: json[FirebaseFieldName.email]);
  @override
  operator ==(covariant UserInfoMode other) =>
      identical(this, other) ||
      (userId == other.userId &&
          email == other.email &&
          displayName == other.displayName);

  @override
  int get hashCode => Object.hashAll([userId, email, displayName]);
}
