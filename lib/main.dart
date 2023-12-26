import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/firebase_options.dart';

import 'dart:developer' as devtools show log;

import 'package:instagram_clone/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone/state/auth/providers/is_login_provider.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
      home: const ProviderScope(child: Home()),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: const Text("Home Page"),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final isloggedIn = ref.watch(isLoggedInProvider);
          if (isloggedIn) {
            return const MainPage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Page")),
      body: Column(
        children: [
          TextButton(
              onPressed: () async {
                ref.read(authStateProvider.notifier).loginWithGoogle();
              },
              child: const Text("Google Login")),
          TextButton(
              onPressed: () async {
                ref.read(authStateProvider.notifier).loginWithFacebook();
              },
              child: const Text("Facebook Login")),
        ],
      ),
    );
  }
}

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main Page")),
      body: ElevatedButton(
          onPressed: () {
            ref.read(authStateProvider.notifier).logout();
          },
          child: const Text("Log Out")),
    );
  }
}
