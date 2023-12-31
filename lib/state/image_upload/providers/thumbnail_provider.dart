import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/image_upload/exceptions/could_not_build_thumbnail.dart';
import 'package:instagram_clone/state/image_upload/extensions/get_image_aspect_ratio.dart';
import 'package:instagram_clone/state/image_upload/models/file_type.dart';
import 'package:instagram_clone/state/image_upload/models/image_with_aspect_ratio.dart';
import 'package:instagram_clone/state/image_upload/models/thumbnail_request.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

final thumbnailProvider =
    FutureProvider.autoDispose.family<ImageWithAspectRation, ThumbnailRequest>(
  (ref, ThumbnailRequest request) async {
    final Image image;

    switch (request.fileType) {
      case FileType.image:
        image = Image.file(
          request.file,
          fit: BoxFit.fitHeight,
        );
        break;
      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
            video: request.file.path,
            imageFormat: ImageFormat.JPEG,
            quality: 70);
        if (thumb == null) {
          throw const CouldNotBuildThumbnail();
        }
        image = Image.memory(
          thumb,
          fit: BoxFit.fitWidth,
        );
    }
    return ImageWithAspectRation(
        image: image, aspectRatio: await image.getAspectRation());
  },
);
