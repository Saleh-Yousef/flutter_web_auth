import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../../context.dart';
import 'global_observalable.dart';

class SettingsBundel {
  dynamic data;
  String? source;
}

abstract class CustomState<T extends StatefulWidget> extends State with LogOut, WidgetsBindingObserver {
  SettingsBundel settingsBundel = SettingsBundel();
  bool _isPaused = false;

  void onResume();
  void onStart();
  void onPause();

  void onStop();

  Future<T?> pushNamed<T>(BuildContext context, String routeName, {Object? arguments, bool rootNavigator = false}) {
    _isPaused = true;
    onStop();
    MainContext().setMainContext(context);
    return Navigator.of(context, rootNavigator: rootNavigator).pushNamed<T>(routeName, arguments: arguments).then((value) {
      _isPaused = false;
      settingsBundel.data = value;
      settingsBundel.source = routeName;
      onStart();

      return value;
    });
  }

  Future<T?> pushNamedAndRemoveUntil<T>(BuildContext context, String routeName,
      {Object? arguments, bool rootNavigator = false, required bool Function(Route) route}) {
    _isPaused = true;
    MainContext().setMainContext(context);

    onStop();
    return Navigator.of(context, rootNavigator: rootNavigator).pushNamedAndRemoveUntil<T>(routeName, route, arguments: arguments).then((value) {
      _isPaused = false;
      settingsBundel.data = value;
      settingsBundel.source = routeName;
      onStart();

      return value;
    });
  }

  Future<void> onSwitchAccount() async {
    GlobalObservable().onAccountChangeStream.add(GlobalEvent.CHANGE_ACCOUNT);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => onStart());
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      if (!_isPaused) {
        onPause();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (!_isPaused) {
        onResume();
      }
    }
  }
}

mixin LogOut {
  Future<bool> onLogout(BuildContext context) async {
    GlobalObservable().onAccountChangeStream.add(GlobalEvent.LOGOUT);

    return Future.value(true);
  }
}
