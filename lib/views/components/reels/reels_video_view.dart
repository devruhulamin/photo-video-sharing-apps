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
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'));
    final isReady = useState(false);

    useEffect(() {
      controller.initialize().then((value) {
        isReady.value = true;
        controller.setLooping(true);
        controller.play();
      });
      return controller.dispose;
    }, []);
    if (isReady.value) {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      );
    } else if (isReady.value == false) {
      return const LoadingAnimationView();
    } else {
      return const ErrorAnimationView();
    }
  }
}
