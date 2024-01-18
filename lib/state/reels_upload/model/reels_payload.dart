import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:instagram_clone/state/post/models/post_key.dart';

import 'package:instagram_clone/state/post/typedefs/user_id.dart';
import 'package:instagram_clone/state/post_settings/models/post_setting.dart';

@immutable
class ReelsPayload extends MapView<String, dynamic> {
  ReelsPayload({
    required String fileUrl,
    required UserId userId,
    required String message,
    required String fileName,
    required String originalFileStorageId,
    required Map<PostSetting, bool> postSettings,
  }) : super({
          PostKey.userId: userId,
          PostKey.fileName: fileName,
          PostKey.message: message,
          PostKey.originalFileStorageId: originalFileStorageId,
          PostKey.fileUrl: fileUrl,
          PostKey.postSettings: {
            for (final postSetting in postSettings.entries)
              postSetting.key.storageKey: postSetting.value,
          }
        });
}
