import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/post_settings/typedefs/is_loading_bool.dart';
import 'package:instagram_clone/state/reels/notifier/reels_upload.dart';

final reelsUploadProvider =
    StateNotifierProvider<ReelsUploadNotifier, IsloadingBool>(
        (ref) => ReelsUploadNotifier());
