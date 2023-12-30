import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone/views/components/dialogs/log_out_dialog.dart';
import 'package:instagram_clone/views/constants/view_strings.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(ViewStrings.appName),
            actions: [
              IconButton(
                onPressed: () async {},
                icon: const FaIcon(FontAwesomeIcons.film),
              ),
              IconButton(
                onPressed: () async {},
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
          ),
        ));
  }
}
