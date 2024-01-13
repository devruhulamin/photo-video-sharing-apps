import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone/state/image_upload/helpers/image_picker_helpers.dart';
import 'package:instagram_clone/state/image_upload/models/file_type.dart';
import 'package:instagram_clone/state/post_settings/providers/post_settings_notifier_provider.dart';
import 'package:instagram_clone/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone/views/components/dialogs/log_out_dialog.dart';
import 'package:instagram_clone/views/constants/view_strings.dart';
import 'package:instagram_clone/views/create_new_post/create_new_post.dart';
import 'package:instagram_clone/views/tabs/home/home_view.dart';
import 'package:instagram_clone/views/tabs/search/search_view.dart';
import 'package:instagram_clone/views/tabs/user_post/user_post_view.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView>
    with SingleTickerProviderStateMixin {
  late final _controller = TabController(length: 3, vsync: this);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.indexIsChanging) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(ViewStrings.appName),
            actions: [
              IconButton(
                onPressed: () async {
                  final videoFile =
                      await ImageOrVideoPicker.pickVieoFromGallery();
                  if (videoFile == null) {
                    return;
                  }
                  ref.invalidate(postSettingProvider);
                  if (!mounted) {
                    return;
                  }
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateNewPost(
                        file: videoFile, fileType: FileType.video),
                  ));
                },
                icon: const FaIcon(FontAwesomeIcons.film),
              ),
              IconButton(
                onPressed: () async {
                  final imageFile =
                      await ImageOrVideoPicker.pickImageFromGallery();
                  if (imageFile == null) {
                    return;
                  }
                  ref.invalidate(postSettingProvider);
                  if (!mounted) {
                    return;
                  }
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateNewPost(
                        file: imageFile, fileType: FileType.image),
                  ));
                },
                icon: const Icon(Icons.add_photo_alternate_outlined),
              ),
              IconButton(
                  onPressed: () async {
                    final shouldLogOut = await const LogOutDialog()
                        .present(context)
                        .then((value) => value ?? false);
                    if (shouldLogOut) {
                      await ref.read(authStateProvider.notifier).logout();
                    }
                  },
                  icon: const Icon(Icons.logout)),
            ],
            bottom: TabBar(
                onTap: (value) {
                  _controller.index = value;
                },
                controller: _controller,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.person),
                  ),
                  Tab(
                    icon: Icon(Icons.search),
                  ),
                  Tab(
                    icon: Icon(Icons.home),
                  ),
                ]),
          ),
          body: TabBarView(controller: _controller, children: const [
            UserPostsView(),
            SearchView(),
            HomeView(),
          ]),
        ));
  }
}
