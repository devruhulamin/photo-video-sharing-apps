import 'package:flutter/material.dart';
import 'package:instagram_clone/views/constants/view_strings.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(ViewStrings.createNewAccount)),
    );
  }
}
