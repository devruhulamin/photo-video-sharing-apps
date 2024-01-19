import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone/state/image_upload/models/file_type.dart';
import 'package:instagram_clone/state/image_upload/models/thumbnail_request.dart';
import 'package:instagram_clone/state/image_upload/providers/image_upload_providers.dart';
import 'package:instagram_clone/state/post_settings/models/post_setting.dart';
import 'package:instagram_clone/state/post_settings/providers/post_settings_notifier_provider.dart';
import 'package:instagram_clone/state/reels/provider/is_video_playing_providero.dart';
import 'package:instagram_clone/state/reels/provider/reels_upload_provider.dart';
import 'package:instagram_clone/views/components/file_thumbnail_view.dart';
import 'package:instagram_clone/views/constants/view_strings.dart';

class CreateNewPost extends StatefulHookConsumerWidget {
  final File file;
  final FileType fileType;
  final bool isReel;
  const CreateNewPost(
      {super.key,
      required this.file,
      required this.fileType,
      this.isReel = false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateNewPostState();
}

class _CreateNewPostState extends ConsumerState<CreateNewPost> {
  @override
  Widget build(BuildContext context) {
    final thumbnailrequest =
        ThumbnailRequest(file: widget.file, fileType: widget.fileType);
    final postSettings = ref.watch(postSettingProvider);
    final postTextController = useTextEditingController();
    final isPostButtonEnable = useState(false);

    useEffect(() {
      void listener() {
        isPostButtonEnable.value = postTextController.value.text.isNotEmpty;
      }

      postTextController.addListener(listener);

      return () {
        if (widget.isReel) {}
        postTextController.removeListener(listener);
      };
    }, [postTextController]);

    return Scaffold(
      appBar: AppBar(
        leading: widget.isReel
            ? IconButton(
                onPressed: () {
                  ref.read(videoPlayBakProvider.notifier).state =
                      VideoPlayBack.play;
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back))
            : IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back)),
        title: const Text(ViewStrings.createNewPost),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: isPostButtonEnable.value
                  ? () async {
                      final userId = ref.watch(userIdProvider);
                      if (userId == null) {
                        return;
                      }
                      bool isUpload;
                      if (!widget.isReel) {
                        isUpload = await ref
                            .read(imageUploadProvider.notifier)
                            .upload(
                                file: widget.file,
                                fileType: widget.fileType,
                                userId: userId,
                                message: postTextController.value.text,
                                postSetting: postSettings);
                      } else {
                        isUpload = await ref
                            .read(reelsUploadProvider.notifier)
                            .upload(
                                file: widget.file,
                                userId: userId,
                                message: postTextController.value.text,
                                postSetting: postSettings);
                      }

                      if (isUpload && mounted) {
                        ref.read(videoPlayBakProvider.notifier).state =
                            VideoPlayBack.play;
                        Navigator.pop(context);
                      }
                    }
                  : null,
              icon: const Icon(Icons.send))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // thumbnail view
            FileThumbnailView(thumbnailRequest: thumbnailrequest),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: ViewStrings.pleaseWriteYourMessageHere,
                ),
                autofocus: true,
                controller: postTextController,
                maxLines: null,
              ),
            ),
            ...PostSetting.values.map((postStng) => ListTile(
                  title: Text(postStng.title),
                  subtitle: Text(postStng.description),
                  trailing: Switch(
                    value: postSettings[postStng] ?? false,
                    onChanged: (value) {
                      ref
                          .read(postSettingProvider.notifier)
                          .setSettng(postStng, value);
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
