import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/post/models/post_key.dart';
import 'package:instagram_clone/state/post/typedefs/user_id.dart';
import 'package:instagram_clone/state/post_settings/models/post_setting.dart';

@immutable
class Reels {
  final String reelId;
  final UserId userId;
  final String filename;
  final String message;
  final DateTime createdAt;
  final String fileUrl;
  final String originalFileStorageId;
  final Map<PostSetting, bool> postSettings;

  Reels({required this.reelId, required Map<String, dynamic> json})
      : userId = json[PostKey.userId],
        filename = json[PostKey.fileName],
        message = json[PostKey.message],
        createdAt = (json[PostKey.createdAt] as Timestamp).toDate(),
        fileUrl = json[PostKey.fileUrl],
        originalFileStorageId = json[PostKey.originalFileStorageId],
        postSettings = {
          for (final entry in json[PostKey.postSettings].entries)
            PostSetting.values
                    .firstWhere((element) => element.storageKey == entry.key):
                entry.value
        };

  bool get allowLikes => postSettings[PostSetting.allowLikes] ?? false;
  bool get allowComments => postSettings[PostSetting.allowComments] ?? false;
}
