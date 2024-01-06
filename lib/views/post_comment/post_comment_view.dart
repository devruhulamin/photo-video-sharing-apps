import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone/state/comment/models/post_comment_request.dart';
import 'package:instagram_clone/state/comment/providers/comment_provider.dart';
import 'package:instagram_clone/state/comment/providers/send_comment_provider.dart';
import 'package:instagram_clone/state/post/typedefs/post_id.dart';
import 'package:instagram_clone/views/components/animations/empty_animation_with_text_view.dart';
import 'package:instagram_clone/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone/views/components/comment/comment_tile.dart';
import 'package:instagram_clone/views/constants/view_strings.dart';
import 'package:instagram_clone/views/extensions/dissmiss_keyboard.dart';

class PostCommentView extends HookConsumerWidget {
  final PostId postId;
  const PostCommentView({super.key, required this.postId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final isTextEmpty = useState(true);
    final commentRequest = useState(RequestForPostAndComment(postId: postId));

    final comments = ref.watch(postCommentProvider(commentRequest.value));

    useEffect(() {
      textController.addListener(() {
        isTextEmpty.value = textController.text.isEmpty;
      });
      return () {};
    }, [textController]);
    return Scaffold(
      appBar: AppBar(
        title: const Text(ViewStrings.comments),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: isTextEmpty.value
                  ? null
                  : () {
                      sendComment(
                          postId: postId, controller: textController, ref: ref);
                    },
              icon: const Icon(Icons.send))
        ],
      ),
      body: SafeArea(
          child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 4,
            child: comments.when(
              data: (commentsData) {
                if (commentsData.isEmpty) {
                  return const SingleChildScrollView(
                    child:
                        EmptyAnimationWithText(text: ViewStrings.noCommentsYet),
                  );
                } else {
                  return RefreshIndicator(
                    child: ListView.builder(
                      itemCount: commentsData.length,
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        final comment = commentsData.elementAt(index);
                        return CommentTile(comment: comment);
                      },
                    ),
                    onRefresh: () {
                      ref.invalidate(postCommentProvider(commentRequest.value));
                      return Future.delayed(const Duration(seconds: 1));
                    },
                  );
                }
              },
              error: (error, stackTrace) => const ErrorAnimationView(),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  textInputAction: TextInputAction.send,
                  controller: textController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: ViewStrings.writeYourCommentHere,
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      sendComment(
                          postId: postId, controller: textController, ref: ref);
                    }
                  },
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  Future<bool> sendComment(
      {required PostId postId,
      required TextEditingController controller,
      required WidgetRef ref}) async {
    final userId = ref.read(userIdProvider);
    'user id is :$userId'.log();
    if (userId == null) {
      return false;
    }
    final result = await ref
        .read(sendCommentProvider.notifier)
        .sendComment(userId: userId, postId: postId, comment: controller.text);
    controller.clear();
    dissMissKeyboard();
    return result;
  }
}
