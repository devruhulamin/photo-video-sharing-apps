import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/firebase_options.dart';

import 'dart:developer' as devtools show log;
import 'package:instagram_clone/state/auth/providers/is_login_provider.dart';
import 'package:instagram_clone/state/providers/is_loading_provider.dart';
import 'package:instagram_clone/views/components/constants/loading/loading_screen.dart';
import 'package:instagram_clone/views/login/login_view.dart';
import 'package:instagram_clone/views/main/main_view.dart';
import 'package:instagram_clone/views/reels/reels_view.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      themeMode: ThemeMode.dark,
      home: Consumer(
        builder: (context, ref, child) {
          ref.listen<bool>(
            isLoadingProvider,
            (_, isLoading) {
              if (isLoading) {
                LoadingScreen.instance().show(
                  context: context,
                );
              } else {
                LoadingScreen.instance().hide();
              }
            },
          );
          final isloggedIn = ref.watch(isLoggedInProvider);
          if (isloggedIn) {
            return const ReelsView();
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}
