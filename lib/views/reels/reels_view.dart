import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/reels/provider/all_reels_provider.dart';
import 'package:instagram_clone/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone/views/reels/reel_item.dart';

class ReelsView extends ConsumerStatefulWidget {
  const ReelsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReelsViewState();
}

class _ReelsViewState extends ConsumerState<ReelsView> {
  @override
  Widget build(BuildContext context) {
    final allreels = ref.watch(allReelsProvider);
    return allreels.when(
      data: (reels) {
        return ReelItem(reels: reels);
      },
      loading: () => const Center(
        child: CircleAvatar(),
      ),
      error: (error, stackTrace) => const ErrorAnimationView(),
    );
  }
}
