import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/main.dart';
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

  final sub2 = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .where("file_type", isEqualTo: "video")
      .snapshots()
      .listen((snapshot) {
    final videos = snapshot.docs
        .map((video) => Reels(reelId: video.id, json: video.data()));
    'found video reels'.log();
    videos.log();
    controller.sink.add(videos);
  });
  ref.onDispose(() {
    sub.cancel();
    sub2.cancel();
    controller.close();
  });
  return controller.stream;
});
