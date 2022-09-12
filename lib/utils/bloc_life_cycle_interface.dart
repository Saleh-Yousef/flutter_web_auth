class BlocLifeCycleInterface {
  void startSubscription({List<dynamic>? arguments}) {}
  void pauseSubscription({List<dynamic>? arguments}) {}
  void resumeSubscription({List<dynamic>? arguments}) {}
  void stopSubscription({List<dynamic>? arguments}) {}
}
