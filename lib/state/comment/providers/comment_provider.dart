import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/comment/extensions/comment_sorting_by_request.dart';
import 'package:instagram_clone/state/comment/models/comment_mode.dart';
import 'package:instagram_clone/state/comment/models/post_comment_request.dart';
import 'package:instagram_clone/state/constant/firebase_collection_name.dart';
import 'package:instagram_clone/state/constant/firebase_field_name.dart';

final postCommentProvider = StreamProvider.autoDispose
    .family<Iterable<CommentModel>, RequestForPostAndComment>(
        (ref, RequestForPostAndComment requestForPostAndComment) {
  final controller = StreamController<Iterable<CommentModel>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.comments)
      .where(FirebaseFieldName.postId,
          isEqualTo: requestForPostAndComment.postId)
      .snapshots()
      .listen((event) {
    final documents = event.docs;
    final limitedDocs = requestForPostAndComment.limit != null
        ? documents.take(requestForPostAndComment.limit!)
        : documents;
    final comments = limitedDocs
        .where((element) => !element.metadata.hasPendingWrites)
        .map((doc) => CommentModel(json: doc.data(), commentid: doc.id));
    final result = comments.applySorting(requestForPostAndComment);
    controller.sink.add(result);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
