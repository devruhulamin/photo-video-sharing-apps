import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/post/notifier/delete_post_notifier.dart';
import 'package:instagram_clone/state/post_settings/typedefs/is_loading_bool.dart';

final deletePostProvider =
    StateNotifierProvider<DeletePostStateNotifier, IsloadingBool>(
        (ref) => DeletePostStateNotifier());
