import 'package:flutter/foundation.dart' show immutable;

@immutable
class Strings {
  static const allowLikesTitle = 'Allow likes';
  static const allowLikesDescription =
      'By allowing likes, users will be able o press the like button on your post';
  static const allowLikesStorageKey = 'allow_likes';
  static const allowCommentsTitle = 'Allow comments';
  static const allowCommentsDescription =
      'By allowing comments, users will be able to comment on your post.';
  static const allowCommentsStorageKey = 'allow_comments';

  static const comment = 'comment';
  static const loading = 'loading...';
  static const person = 'person';
  static const people = 'people';
  static const likedThis = 'liked this';

  static const delete = 'Delete';
  static const areYourSureWantToDeleteThis = 'Are you sure want to delete this';
  static const logout = 'Log out';
  static const areYouSureWantToLogoutThis =
      'Are you sure want to log out of this app';
  static const canel = 'Cancel';

  const Strings._();
}
