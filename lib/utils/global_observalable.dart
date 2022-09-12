import 'dart:async';
import 'dart:ui';

class GlobalObservable {
  StreamController<GlobalEvent> onAccountChangeStream = StreamController<GlobalEvent>.broadcast();
  StreamController<AppLifecycleState> appLifecycleStateStream = StreamController<AppLifecycleState>.broadcast();
  StreamController<String> rebuildTextLanguage = StreamController<String>.broadcast();
  StreamController<String> appThemeUpdateStream = StreamController<String>.broadcast();
}

enum GlobalEvent { LOGOUT, CHANGE_ACCOUNT }
