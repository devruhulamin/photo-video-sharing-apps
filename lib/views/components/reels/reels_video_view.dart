import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:instagram_clone/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone/views/components/animations/loading_animation_view.dart';
import 'package:video_player/video_player.dart';

class ReelVideoView extends HookWidget {
  const ReelVideoView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://github.com/devruhulamin/photo-video-sharing-apps/raw/main/testvideo/t1.mp4'));
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
