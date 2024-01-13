import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginRegister extends HookConsumerWidget {
  const LoginRegister({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isEnabled = useState(false);

    useEffect(() {
      return null;
    }, [emailController, passwordController]);

    return Column(
      children: [
        TextFormField(
          controller: emailController,
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: passwordController,
        )
      ],
    );
  }
}
