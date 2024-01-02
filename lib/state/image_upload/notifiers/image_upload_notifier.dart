import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/constant/firebase_collection_name.dart';
import 'package:instagram_clone/state/image_upload/constants/constants.dart';
import 'package:instagram_clone/state/image_upload/exceptions/could_not_build_thumbnail.dart';
import 'package:instagram_clone/state/image_upload/extensions/get_collection_name_from_file_type.dart';
import 'package:instagram_clone/state/image_upload/extensions/get_image_data_aspect_ratio.dart';
import 'package:instagram_clone/state/image_upload/models/file_type.dart';
import 'package:instagram_clone/state/post/models/post_payload.dart';
import 'package:instagram_clone/state/post/typedefs/user_id.dart';
import 'package:instagram_clone/state/post_settings/models/post_setting.dart';
import 'package:instagram_clone/state/post_settings/typedefs/is_loading_bool.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ImageUploadNotifier extends StateNotifier<IsloadingBool> {
  ImageUploadNotifier() : super(false);

  set isLoading(bool loadingState) => state = loadingState;

  Future<bool> upload({
    required File file,
    required FileType fileType,
    required UserId userId,
    required String message,
    required Map<PostSetting, bool> postSetting,
  }) async {
    isLoading = true;
    late Uint8List thumbnailImageDataUin8List;
    switch (fileType) {
      case FileType.image:
        final fileAsImage = img.decodeImage(file.readAsBytesSync());
        if (fileAsImage == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnail();
        }
        final thumbnail = img.copyResize(fileAsImage,
            width: ImageUploadConstant.imageThumbnailWidth);
        final thumbnailData = img.encodeJpg(thumbnail);
        thumbnailImageDataUin8List = thumbnailData;
        break;
      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
          video: file.path,
          imageFormat: ImageFormat.JPEG,
          maxHeight: ImageUploadConstant.videoThumbnailMaxHeight,
          quality: ImageUploadConstant.videoThumbnailQuality,
        );
        if (thumb == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnail();
        }
        thumbnailImageDataUin8List = thumb;
        break;
    }
    final thumbnailAspectRation =
        await thumbnailImageDataUin8List.getImageAspectRation();
    final fileName = const Uuid().v4();
    final thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FirebaseCollectionName.thumbnails)
        .child(fileName);
    final originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileType.getCollectionName)
        .child(fileName);
    try {
      // upload thumbail
      final thumbnaiUploadTask =
          await thumbnailRef.putData(thumbnailImageDataUin8List);
      final thumbnailStorageId = thumbnaiUploadTask.ref.name;
      // upload original file
      final originalUploadTask =
          await originalFileRef.putData(file.readAsBytesSync());
      final originalStorageId = originalUploadTask.ref.name;

      // upload the post
      final postPayload = PostPayload(
        userId: userId,
        message: message,
        thumbnailUrl: await thumbnailRef.getDownloadURL(),
        fileUrl: await originalFileRef.getDownloadURL(),
        fileType: fileType,
        fileName: fileName,
        aspectRatio: thumbnailAspectRation,
        thumbnailStorageId: thumbnailStorageId,
        originalFileStorageId: originalStorageId,
        postSettings: postSetting,
      );
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .add(postPayload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
