import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/comment/models/comment_payload.dart';
import 'package:instagram_clone/state/constant/firebase_collection_name.dart';
import 'package:instagram_clone/state/post/typedefs/post_id.dart';
import 'package:instagram_clone/state/post/typedefs/user_id.dart';
import 'package:instagram_clone/state/post_settings/typedefs/is_loading_bool.dart';

class SendCommentNotifier extends StateNotifier<IsloadingBool> {
  SendCommentNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> sendComment({
    required UserId userId,
    required PostId postId,
    required String comment,
  }) async {
    final commentPayload =
        CommentPayload(userId: userId, postId: postId, comment: comment);

    try {
      isLoading = true;
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.comments)
          .add(commentPayload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
