import 'dart:collection';

import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/constant/firebase_field_name.dart';
import 'package:instagram_clone/state/post/typedefs/user_id.dart';

@immutable
class UserInfoModel extends MapView<String, dynamic> {
  final UserId userId;
  final String displayName;
  final String? email;

  UserInfoModel(
      {required this.userId, required this.displayName, required this.email})
      : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email,
        });

  UserInfoModel.fromJson(
      {required Map<String, dynamic> json, required UserId userId})
      : this(
            userId: json[FirebaseFieldName.userId],
            displayName: json[FirebaseFieldName.displayName] ?? '',
            email: json[FirebaseFieldName.email]);
  @override
  operator ==(covariant UserInfoModel other) =>
      identical(this, other) ||
      (runtimeType == other.runtimeType &&
          userId == other.userId &&
          email == other.email &&
          displayName == other.displayName);

  @override
  int get hashCode => Object.hashAll([runtimeType, userId, email, displayName]);
}
