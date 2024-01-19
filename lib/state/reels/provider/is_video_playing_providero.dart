import 'package:hooks_riverpod/hooks_riverpod.dart';

final videoPlayBakProvider = StateProvider<VideoPlayBack>((ref) {
  return VideoPlayBack.play;
});

enum VideoPlayBack { play, pause }
