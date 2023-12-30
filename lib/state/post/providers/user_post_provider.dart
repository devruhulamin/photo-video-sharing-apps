import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone/state/constant/firebase_collection_name.dart';
import 'package:instagram_clone/state/constant/firebase_field_name.dart';
import 'package:instagram_clone/state/post/models/post.dart';
import 'package:instagram_clone/state/post/models/post_key.dart';

final userPostProvider = StreamProvider.autoDispose<Iterable<Post>>((ref) {
  final userId = ref.watch(userIdProvider);
  final controller = StreamController<Iterable<Post>>();
  controller.onListen = () {
    controller.sink.add([]);
  };
  final storageSub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .orderBy(FirebaseFieldName.createAt, descending: true)
      .where(PostKey.userId, isEqualTo: userId)
      .snapshots()
      .listen((snapshots) {
    final document = snapshots.docs;
    final posts = document
        .where((element) => !element.metadata.hasPendingWrites)
        .map((post) => Post(postId: post.id, json: post.data()));
    controller.sink.add(posts);
  });

  ref.onDispose(() {
    storageSub.cancel();
    controller.close();
  });
  return controller.stream;
});
