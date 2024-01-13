import 'package:flutter/material.dart';
import 'package:instagram_clone/views/components/login/loign_register.dart';
import 'package:instagram_clone/views/constants/view_strings.dart';
import 'package:instagram_clone/views/login/divider_with_margin.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(ViewStrings.createNewAccount)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                ViewStrings.welcomeToAppName,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const DividerWithMargin(),
              Text(
                ViewStrings.registerYourAccountUsingEmail,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(height: 1.5),
              ),
              const SizedBox(
                height: 20,
              ),
              const LoginRegister(
                isRegister: true,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
