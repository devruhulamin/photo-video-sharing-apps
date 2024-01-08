import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/constant/firebase_collection_name.dart';
import 'package:instagram_clone/state/constant/firebase_field_name.dart';
import 'package:instagram_clone/state/likes/models/like.dart';
import 'package:instagram_clone/state/likes/models/likes_dislike_request.dart';

final likeDislikePostProvider = FutureProvider.autoDispose
    .family<bool, LikeDislikeRequest>((ref, LikeDislikeRequest request) async {
  final query = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.likes)
      .where(FirebaseFieldName.postId, isEqualTo: request.postId)
      .where(FirebaseFieldName.userId, isEqualTo: request.likedBy)
      .get();
  final isLiked = await query.then((snapshot) => snapshot.docs.isNotEmpty);

  if (isLiked) {
// delete the like
    try {
      await query.then((value) async {
        for (final doc in value.docs) {
          await doc.reference.delete();
        }
      });
      return true;
    } catch (_) {
      return false;
    }
  } else {
    // add a like
    try {
      final likeData = Like(
          postId: request.postId,
          likedBy: request.likedBy,
          dateTime: DateTime.now());
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.likes)
          .add(likeData);
    } catch (_) {
      return false;
    }
  }
});
