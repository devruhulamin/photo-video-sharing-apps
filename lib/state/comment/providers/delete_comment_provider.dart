import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/comment/notifiers/delete_comment_notifier.dart';
import 'package:instagram_clone/state/post_settings/typedefs/is_loading_bool.dart';

final deleteCommentProvider =
    StateNotifierProvider<DeleteCommentNotifier, IsloadingBool>(
        (ref) => DeleteCommentNotifier());
