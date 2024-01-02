import 'dart:io';

import 'package:image_picker/image_picker.dart';

extension XFileToFile on Future<XFile?> {
  Future<File?> get toFile => then((xfile) => xfile?.path)
      .then((filePath) => filePath != null ? File(filePath) : null);
}
