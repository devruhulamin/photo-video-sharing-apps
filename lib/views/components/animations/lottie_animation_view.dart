import 'package:flutter/material.dart';
import 'package:instagram_clone/views/components/animations/models/lottie_animation.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationView extends StatelessWidget {
  final LottieAnimation animation;
  final bool repeat;
  final bool reverse;
  const LottieAnimationView(
      {super.key,
      required this.animation,
      this.repeat = true,
      this.reverse = false});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(animation.getFullPath,
        repeat: repeat, reverse: reverse);
  }
}

extension GetLottieAnimationFullPath on LottieAnimation {
  String get getFullPath => 'assets/animations/$name.json';
}
