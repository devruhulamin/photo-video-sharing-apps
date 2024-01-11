import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/enums/date_sorting.dart';
import 'package:instagram_clone/state/comment/models/post_comment_request.dart';
import 'package:instagram_clone/state/post/models/post.dart';
import 'package:instagram_clone/state/post/providers/can_current_user_delete_post_provider.dart';
import 'package:instagram_clone/state/post/providers/delete_post_provider.dart';
import 'package:instagram_clone/state/post/providers/specific_post_with_comments.dart';
import 'package:instagram_clone/views/components/animations/small_error_animaion_view.dart';
import 'package:instagram_clone/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone/views/components/dialogs/delete_alert_dialog.dart';
import 'package:instagram_clone/views/constants/view_strings.dart';
import 'package:share_plus/share_plus.dart';

class PostDetailsView extends StatefulHookConsumerWidget {
  final Post post;
  const PostDetailsView({super.key, required this.post});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailsViewState();
}

class _PostDetailsViewState extends ConsumerState<PostDetailsView> {
  @override
  Widget build(BuildContext context) {
    // setup post and comment setting
    final requestPostAndComment = RequestForPostAndComment(
        postId: widget.post.postId,
        sortBycreatedAt: true,
        dateSorting: DateSorting.oldestOnTop,
        limit: 3);

    // get the actual post with its comment
    final postWithComment =
        ref.watch(specificPostWithCommentsProvider(requestPostAndComment));
    // get is this user can delete the post

    final canDeletePost =
        ref.watch(canCurrentUserDeleteThisPostProvider(widget.post));

    return Scaffold(
      appBar: AppBar(
        title: const Text(ViewStrings.postDetails),
        actions: [
          postWithComment.when(
            data: (postData) {
              return IconButton(
                  onPressed: () {
                    final postUrl = postData.post.fileUrl;
                    Share.share(postUrl, subject: ViewStrings.checkOutThisPost);
                  },
                  icon: const Icon(Icons.share));
            },
            error: (error, stackTrace) => const SmallErrorAnimationView(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          if (canDeletePost.value ?? false)
            IconButton(
                onPressed: () async {
                  final shouldDelete = await DeleteDialog(
                          titleOfObjectToDelete: ViewStrings.post)
                      .present(context)
                      .then((value) => value ?? false);
                  if (shouldDelete) {
                    final isSucced = await ref
                        .read(deletePostProvider.notifier)
                        .deletePost(post: widget.post);
                    if (isSucced && mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                },
                icon: const Icon(Icons.delete))
        ],
      ),
    );
  }
}
