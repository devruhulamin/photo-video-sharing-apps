import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/image_upload/helpers/image_picker_helpers.dart';
import 'package:instagram_clone/state/image_upload/models/file_type.dart';
import 'package:instagram_clone/state/post_settings/providers/post_settings_notifier_provider.dart';
import 'package:instagram_clone/views/create_new_post/create_new_post.dart';

class ReelsUploadButton extends ConsumerStatefulWidget {
  const ReelsUploadButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReelsUploadButtonState();
}

class _ReelsUploadButtonState extends ConsumerState<ReelsUploadButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          final reelFile = await ImageOrVideoPicker.pickVieoFromGallery();
          if (reelFile == null) {
            return;
          }
          if (!mounted) {
            return;
          }
          ref.invalidate(postSettingProvider);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CreateNewPost(
              file: reelFile,
              fileType: FileType.video,
              isReel: true,
            ),
          ));
        },
        icon: const CircleAvatar(
            backgroundColor: Colors.red, child: Icon(Icons.upload_outlined)));
  }
}
