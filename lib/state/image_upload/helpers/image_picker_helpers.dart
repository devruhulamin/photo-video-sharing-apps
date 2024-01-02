import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/state/image_upload/extensions/xfile_to_file.dart';

@immutable
class ImageOrVideoPicker {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<File?> pickImageFromGallery() =>
      _imagePicker.pickImage(source: ImageSource.gallery).toFile;

  static Future<File?> pickVieoFromGallery() =>
      _imagePicker.pickVideo(source: ImageSource.gallery).toFile;
}
