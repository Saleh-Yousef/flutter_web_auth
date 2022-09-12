import 'package:aumet_assessment/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/home_screen/home_screen.dart';
import 'auth_provider.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
        data: (data) {
          if (data != null) return const HomeScreen();
          return const LoginScreen();
        },
        loading: () => const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 1.5,
            ),
        error: (e, trace) => Container());
  }
}
