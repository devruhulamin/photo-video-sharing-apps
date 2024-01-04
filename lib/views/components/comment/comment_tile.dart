import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone/state/comment/models/comment_mode.dart';
import 'package:instagram_clone/state/comment/providers/delete_comment_provider.dart';
import 'package:instagram_clone/state/user_info/providers/user_info_model_provider.dart';
import 'package:instagram_clone/views/components/animations/small_error_animaion_view.dart';
import 'package:instagram_clone/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone/views/components/dialogs/delete_alert_dialog.dart';
import 'package:instagram_clone/views/constants/view_strings.dart';

class CommentTile extends ConsumerWidget {
  final CommentModel comment;
  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userInfoModelProvider(comment.userId));
    final userId = ref.read(userIdProvider);
    return userData.when(
      data: (userInfo) {
        return ListTile(
          title: Text(comment.comment),
          subtitle: comment.userId == userId
              ? IconButton(
                  onPressed: () async {
                    final shouldDelete = await displayShouldDelete(context);
                    if (shouldDelete) {
                      ref
                          .read(deleteCommentProvider.notifier)
                          .deleteComment(commentId: comment.commentId);
                    }
                  },
                  icon: const Icon(Icons.delete))
              : null,
        );
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<bool> displayShouldDelete(BuildContext context) async {
    return DeleteDialog(titleOfObjectToDelete: ViewStrings.comments)
        .present(context)
        .then((value) => value ?? false);
  }
}
