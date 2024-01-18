import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:instagram_clone/state/reels/model/reels.dart';
import 'package:instagram_clone/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone/views/components/animations/loading_animation_view.dart';
import 'package:video_player/video_player.dart';

class ReelVideoView extends HookWidget {
  final Reels reel;
  const ReelVideoView({super.key, required this.reel});

  @override
  Widget build(BuildContext context) {
    final controller =
        VideoPlayerController.networkUrl(Uri.parse(reel.fileUrl));
    final isVideoPlayerReady = useState(false);

    useEffect(() {
      controller.initialize().then((value) {
        isVideoPlayerReady.value = true;
        controller.setLooping(true);
        controller.play();
      });
      return controller.dispose;
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
