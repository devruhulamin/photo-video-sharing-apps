import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/constant/firebase_collection_name.dart';
import 'package:instagram_clone/state/post/typedefs/user_id.dart';
import 'package:instagram_clone/state/post_settings/models/post_setting.dart';
import 'package:instagram_clone/state/post_settings/typedefs/is_loading_bool.dart';
import 'package:instagram_clone/state/reels_upload/model/reels_payload.dart';
import 'package:uuid/uuid.dart';

class ReelsUploadNotifier extends StateNotifier<IsloadingBool> {
  ReelsUploadNotifier() : super(false);
  set isLoading(bool loading) => state = loading;

  Future<bool> upload({
    required File file,
    required UserId userId,
    required String message,
    required Map<PostSetting, bool> postSetting,
  }) async {
    isLoading = true;
    final fileName = const Uuid().v4();
    final originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child('reels')
        .child(fileName);
    try {
      final reelUploadTask =
          await originalFileRef.putData(file.readAsBytesSync());
      final originalStorageId = reelUploadTask.ref.name;
      final reelPayload = ReelsPayload(
          fileUrl: await originalFileRef.getDownloadURL(),
          userId: userId,
          message: message,
          fileName: fileName,
          originalFileStorageId: originalStorageId,
          postSettings: postSetting);
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.reels)
          .add(reelPayload);

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
