import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/comment/extensions/comment_sorting_by_request.dart';
import 'package:instagram_clone/state/comment/models/comment_mode.dart';
import 'package:instagram_clone/state/comment/models/post_comment_request.dart';
import 'package:instagram_clone/state/comment/models/post_with_comments.dart';
import 'package:instagram_clone/state/constant/firebase_collection_name.dart';
import 'package:instagram_clone/state/constant/firebase_field_name.dart';
import 'package:instagram_clone/state/post/models/post.dart';

final specificPostWithCommentsProvider = StreamProvider.autoDispose
    .family<PostWithComments, RequestForPostAndComment>(
        (ref, RequestForPostAndComment request) {
  final controller = StreamController<PostWithComments>();

  Post? post;
  Iterable<CommentModel>? comments;

  void notify() {
    final currentPost = post;
    if (currentPost == null) {
      return;
    }
    final currentcomments = (comments ?? []).applySorting(request);

    final postwithcomments =
        PostWithComments(post: currentPost, comments: currentcomments);
    controller.sink.add(postwithcomments);
  }

  final postSub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .where(FieldPath.documentId, isEqualTo: request.postId)
      .limit(1)
      .snapshots()
      .listen((snapshots) {
    if (snapshots.docs.isEmpty) {
      post = null;
      comments = null;
      notify();
      return;
    }
    final doc = snapshots.docs.first;
    if (doc.metadata.hasPendingWrites) {
      return;
    }
    post = Post(postId: doc.id, json: doc.data());
    notify();
  });

  final commentQuery = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.comments)
      .where(FirebaseFieldName.postId, isEqualTo: request.postId)
      .orderBy(FirebaseFieldName.createdAt, descending: true);
  final limitedCommentQuery =
      request.limit != null ? commentQuery.limit(request.limit!) : commentQuery;

  final commentSub = limitedCommentQuery.snapshots().listen((snashots) {
    final docs = snashots.docs.where((doc) => !doc.metadata.hasPendingWrites);

    comments =
        docs.map((doc) => CommentModel(json: doc.data(), commentid: doc.id));

    notify();
  });
  ref.onDispose(() {
    postSub.cancel();
    commentSub.cancel();
    controller.close();
  });
  return controller.stream;
});
