import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/constant/firebase_collection_name.dart';
import 'package:instagram_clone/state/reels/model/reels.dart';

final allReelsProvider = StreamProvider.autoDispose<Iterable<Reels>>((ref) {
  final controller = StreamController<Iterable<Reels>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.reels)
      .snapshots()
      .listen((snapshot) {
    final reels = snapshot.docs
        .where((doc) => !doc.metadata.hasPendingWrites)
        .map((doc) => Reels(reelId: doc.id, json: doc.data()));
    controller.sink.add(reels);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
