import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/enums/date_sorting.dart';
import 'package:instagram_clone/state/comment/models/post_comment_request.dart';
import 'package:instagram_clone/state/post/models/post.dart';
import 'package:instagram_clone/state/post/providers/can_current_user_delete_post_provider.dart';
import 'package:instagram_clone/state/post/providers/delete_post_provider.dart';
import 'package:instagram_clone/state/post/providers/specific_post_with_comments.dart';
import 'package:instagram_clone/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone/views/components/animations/small_error_animaion_view.dart';
import 'package:instagram_clone/views/components/comment/compact_comment_column.dart';
import 'package:instagram_clone/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone/views/components/dialogs/delete_alert_dialog.dart';
import 'package:instagram_clone/views/components/post/like_button.dart';
import 'package:instagram_clone/views/components/post/likes_count_view.dart';
import 'package:instagram_clone/views/components/post/post_date_view.dart';
import 'package:instagram_clone/views/components/post/post_display_name_and_message_view.dart';
import 'package:instagram_clone/views/components/post/post_image_or_video_view.dart';
import 'package:instagram_clone/views/constants/view_strings.dart';
import 'package:instagram_clone/views/post_comment/post_comment_view.dart';
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
      body: postWithComment.when(
        data: (postAndComments) {
          final postId = postAndComments.post.postId;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PostImageOrVideoView(post: postAndComments.post),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (postAndComments.post.allowLikes)
                      LikeButton(postId: postId),
                    const SizedBox(
                      width: 5,
                    ),
                    if (postAndComments.post.allowComments)
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PostCommentView(postId: postId),
                            ));
                          },
                          icon: const Icon(Icons.mode_comment_outlined))
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                PostDisplayNameAndMessageView(post: postAndComments.post),
                const SizedBox(
                  height: 5,
                ),
                PostDateView(dateTime: postAndComments.post.createdAt),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Divider(
                    color: Colors.white54,
                  ),
                ),
                CompactCommentColumn(comments: postAndComments.comments),
                if (postAndComments.post.allowLikes)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        LikesCountView(postId: postId),
                      ],
                    ),
                  )
              ],
            ),
          );
        },
        error: (error, stackTrace) => const ErrorAnimationView(),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
