import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/views/components/reels/reels_action_buttons.dart';

class ReelsView extends ConsumerStatefulWidget {
  const ReelsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReelsViewState();
}

class _ReelsViewState extends ConsumerState<ReelsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://source.unsplash.com/user/c_v_r/700x700',
                      ))),
              child: const Stack(
                children: [
                  Positioned(
                    bottom: 10,
                    right: 20,
                    child: ReelsActionButton(),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 15,
                              child: Icon(
                                Icons.person,
                                size: 15,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text('Ruhul Amin'),
                          ],
                        ),
                        Text(
                          'Beautiful Mosque with nice song..',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
