import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/constant/firebase_collection_name.dart';
import 'package:instagram_clone/state/constant/firebase_field_name.dart';
import 'package:instagram_clone/state/image_upload/extensions/get_collection_name_from_file_type.dart';
import 'package:instagram_clone/state/post/models/post.dart';
import 'package:instagram_clone/state/post/typedefs/post_id.dart';
import 'package:instagram_clone/state/post_settings/typedefs/is_loading_bool.dart';

class DeletePostStateNotifier extends StateNotifier<IsloadingBool> {
  DeletePostStateNotifier() : super(false);

  set isloading(bool value) => state = value;
  Future<bool> deletePost({required Post post}) async {
    try {
      isloading = true;
      // delete the post thumbnail
      await FirebaseStorage.instance
          .ref()
          .child(post.userId)
          .child(FirebaseCollectionName.thumbnails)
          .child(post.thumbnailStorageId)
          .delete();
      // delete the post file
      await FirebaseStorage.instance
          .ref()
          .child(post.userId)
          .child(post.fileType.getCollectionName)
          .child(post.thumbnailStorageId)
          .delete();
      // delete all the post comments
      await _deleteAllDocuments(
          postId: post.postId, inCollection: FirebaseCollectionName.comments);
      // delete all the post likes

      await _deleteAllDocuments(
          postId: post.postId, inCollection: FirebaseCollectionName.likes);
      // delete the actual post
      final postCollection = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .where(FieldPath.documentId, isEqualTo: post.postId)
          .limit(1)
          .get();
      for (final post in postCollection.docs) {
        await post.reference.delete();
      }
      return true;
    } catch (_) {
      return false;
    } finally {
      isloading = false;
    }
  }

  Future<void> _deleteAllDocuments(
      {required PostId postId, required String inCollection}) async {
    return FirebaseFirestore.instance.runTransaction(
      maxAttempts: 3,
      timeout: const Duration(seconds: 3),
      (transaction) async {
        final query = await FirebaseFirestore.instance
            .collection(inCollection)
            .where(FirebaseFieldName.postId, isEqualTo: postId)
            .get();
        for (final doc in query.docs) {
          transaction.delete(doc.reference);
        }
      },
    );
  }
}
