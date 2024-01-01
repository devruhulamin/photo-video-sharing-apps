import 'package:instagram_clone/state/image_upload/models/file_type.dart';

extension GetCollectionNameFromFileType on FileType {
  String get getCollectionName {
    switch (this) {
      case FileType.image:
        return 'images';
      case FileType.video:
        return 'videos';
    }
  }
}
