import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/state/reels/model/reels.dart';
import 'package:instagram_clone/state/reels/provider/is_video_playing_providero.dart';
import 'package:instagram_clone/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone/views/components/animations/loading_animation_view.dart';
import 'package:video_player/video_player.dart';

class ReelVideView extends HookConsumerWidget {
  final Reels reel;
  const ReelVideView({super.key, required this.reel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = VideoPlayerController.networkUrl(Uri.parse(reel.fileUrl),
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false));
    final isVideoPlayerReady = useState(false);
    final videoPlayBack = ref.watch(videoPlayBakProvider);

    useEffect(() {
      controller.initialize().then((value) {
        isVideoPlayerReady.value = true;
        controller.setLooping(true);
        switch (videoPlayBack) {
          case VideoPlayBack.play:
            controller.play();
          case VideoPlayBack.pause:
            controller.pause();
        }
      });
      return () {
        controller.dispose();
      };
    }, [controller]);

    switch (isVideoPlayerReady.value) {
      case true:
        return AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        );
      case false:
        return const LoadingAnimationView();
      default:
        return const ErrorAnimationView();
    }
  }
}
