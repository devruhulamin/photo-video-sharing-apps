import 'package:flutter/material.dart';
import 'package:instagram_clone/state/reels/model/reels.dart';
import 'package:instagram_clone/views/components/reels/reels_action_buttons.dart';
import 'package:instagram_clone/views/components/reels/reels_upload_button.dart';
import 'package:instagram_clone/views/components/reels/reels_video_view.dart';

class ReelItem extends StatelessWidget {
  final Iterable<Reels> reels;
  const ReelItem({super.key, required this.reels});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: reels.length,
        itemBuilder: (context, index) {
          return Stack(
            fit: StackFit.expand,
            children: [
              ReelVideView(
                reel: reels.elementAt(index),
              ),
              const Positioned(top: 10, right: 10, child: ReelsUploadButton()),
              Positioned(
                bottom: 10,
                right: 20,
                child: ReelsActionButton(
                  reels: reels.elementAt(index),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
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
                      reels.elementAt(index).message,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
