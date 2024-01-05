import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone/state/comment/models/post_comment_request.dart';
import 'package:instagram_clone/state/comment/providers/comment_provider.dart';
import 'package:instagram_clone/state/comment/providers/send_comment_provider.dart';
import 'package:instagram_clone/state/post/typedefs/post_id.dart';
import 'package:instagram_clone/views/constants/view_strings.dart';
import 'package:instagram_clone/views/extensions/dissmiss_keyboard.dart';

class PostCommentView extends HookConsumerWidget {
  final PostId postId;
  const PostCommentView({super.key, required this.postId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final isTextEmpty = useState(true);
    final commentRequest = RequestForPostAndComment(postId: postId);

    final comments = ref.watch(postCommentProvider(commentRequest));

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
    );
  }

  Future<bool> sendComment(
      {required PostId postId,
      required TextEditingController controller,
      required WidgetRef ref}) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) {
      return false;
    }
    final result = await ref
        .read(sendCommentProvider.notifier)
        .sendComment(userId: userId, postId: postId, comment: controller.text);
    dissMissKeyboard();
    return result;
  }
}
