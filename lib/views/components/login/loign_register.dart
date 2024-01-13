import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone/views/constants/view_strings.dart';
import 'package:instagram_clone/views/extensions/email_validation.dart';
import 'package:instagram_clone/views/extensions/password_validation.dart';

class LoginRegister extends HookConsumerWidget {
  final bool isRegister;
  const LoginRegister({super.key, this.isRegister = false});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isEnabled = useState(false);

    useEffect(() {
      void listener() {
        isEnabled.value = passwordController.text.isPasswordValid() &&
            emailController.text.isValidEmail();
      }

      emailController.addListener(listener);
      passwordController.addListener(listener);

      return () {
        emailController.removeListener(listener);
        passwordController.removeListener(listener);
      };
    }, [emailController, passwordController]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(
              labelText: ViewStrings.emailAddress,
              border: OutlineInputBorder()),
        ),
        const SizedBox(
          height: 14,
        ),
        TextFormField(
          controller: passwordController,
          decoration: const InputDecoration(
              labelText: ViewStrings.password, border: OutlineInputBorder()),
        ),
        const SizedBox(
          height: 14,
        ),
        ElevatedButton(
            onPressed: isEnabled.value
                ? () {
                    final authState = ref.read(authStateProvider.notifier);
                    isRegister
                        ? authState.signUpWithEmailPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        : authState.loginWithEmailPassword(
                            email: emailController.text,
                            password: passwordController.text);
                  }
                : null,
            child: Text(isRegister ? ViewStrings.register : ViewStrings.login))
      ],
    );
  }
}
