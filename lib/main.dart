import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routes.dart';
import 'utils/auth_checker.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: App(navigatorKey)));
}

class App extends ConsumerWidget {
  final GlobalKey<NavigatorState> appKey;
  const App(this.appKey, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        onGenerateRoute: (RouteSettings settings) {
          return PageRouteBuilder(
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return SlideTransition(
                textDirection: TextDirection.ltr,
                position: Tween<Offset>(
                  begin: const Offset(-1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
            settings: RouteSettings(arguments: settings.arguments),
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (ctx, an1, an2) => routes[settings.name!]!,
          );
        },
        navigatorKey: appKey,
        debugShowCheckedModeBanner: false,
        navigatorObservers: [
          RouteObserver<PageRoute>(),
        ],
        home: const AuthChecker());
  }
}
