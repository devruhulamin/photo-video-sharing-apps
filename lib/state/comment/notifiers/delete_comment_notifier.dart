import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/comment/type_defs/comment_type.dart';
import 'package:instagram_clone/state/constant/firebase_collection_name.dart';
import 'package:instagram_clone/state/post_settings/typedefs/is_loading_bool.dart';

class DeleteCommentNotifier extends StateNotifier<IsloadingBool> {
  DeleteCommentNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> deleteComment({required CommentId commentId}) async {
    try {
      isLoading = true;
      final query = FirebaseFirestore.instance
          .collection(FirebaseCollectionName.comments)
          .where(FieldPath.documentId, isEqualTo: commentId)
          .limit(1)
          .get();
      await query.then((query) async {
        for (final doc in query.docs) {
          await doc.reference.delete();
        }
      });
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
