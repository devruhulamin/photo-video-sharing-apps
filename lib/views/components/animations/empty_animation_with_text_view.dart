import 'package:flutter/material.dart';
import 'package:instagram_clone/views/components/animations/empty_animation_view.dart';

class EmptyAnimationWithText extends StatelessWidget {
  const EmptyAnimationWithText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white54),
            ),
          ),
          const EmptyAnimationView()
        ],
      ),
    );
  }
}
