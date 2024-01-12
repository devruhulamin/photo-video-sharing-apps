import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/constant/firebase_collection_name.dart';
import 'package:instagram_clone/state/constant/firebase_field_name.dart';
import 'package:instagram_clone/state/post/models/post.dart';
import 'package:instagram_clone/state/post/typedefs/search_term.dart';

final postsBySearchTermProvider = StreamProvider.autoDispose
    .family<Iterable<Post>, SearchTerm>((ref, SearchTerm searchTerm) {
  final controller = StreamController<Iterable<Post>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .orderBy(FirebaseFieldName.createdAt, descending: true)
      .snapshots()
      .listen((snapshots) {
    final posts = snapshots.docs
        .map((post) => Post(postId: post.id, json: post.data()))
        .where((post) =>
            post.message.toLowerCase().contains(searchTerm.toLowerCase()));

    controller.sink.add(posts);
  });
  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
