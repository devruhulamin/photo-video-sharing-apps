import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/image_upload/notifiers/image_upload_notifier.dart';
import 'package:instagram_clone/state/post_settings/typedefs/is_loading_bool.dart';

final imageUploadProvider =
    StateNotifierProvider<ImageUploadNotifier, IsloadingBool>(
        (ref) => ImageUploadNotifier());
