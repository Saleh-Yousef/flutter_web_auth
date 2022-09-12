import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/bloc_life_cycle_interface.dart';

class LoginBloc with ChangeNotifier implements BlocLifeCycleInterface {
  final loginProvider = ChangeNotifierProvider<LoginBloc>((ref) {
    return LoginBloc();
  });
  String title = '';
  final TextEditingController signUpUserNameFieldController = TextEditingController();
  final TextEditingController signUpPhoneFieldController = TextEditingController();
  final TextEditingController signUpEmailFieldController = TextEditingController();
  final TextEditingController signUpPasswordFieldController = TextEditingController();
  final TextEditingController signInEmailFieldController = TextEditingController();
  final TextEditingController signInPasswordFieldController = TextEditingController();

  bool obscurePasswordText = true;

  String errorEmailMessage = '';
  String errorPasswordMessage = '';

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    return (!regex.hasMatch(value)) ? false : true;
  }

  void onPressedLoginButton() {
    errorEmailMessage = '';
    errorPasswordMessage = '';
    if (signInEmailFieldController.text.isNotEmpty && validateEmail(signInEmailFieldController.text.trim())) {
    } else {
      errorEmailMessage = 'Please Enter Valid Email';
    }
    if (signInPasswordFieldController.text.isEmpty) {
      errorPasswordMessage = 'Please Enter Password';
    }
    notifyListeners();
  }

  void showHidePassword() {
    obscurePasswordText = !obscurePasswordText;
    notifyListeners();
  }

  @override
  void pauseSubscription({List? arguments}) {
    // TODO: implement pauseSubscription
  }

  @override
  void resumeSubscription({List? arguments}) {
    // TODO: implement resumeSubscription
  }

  @override
  void startSubscription({List? arguments}) {
    // TODO: implement startSubscription
  }

  @override
  void stopSubscription({List? arguments}) {
    // TODO: implement stopSubscription
  }

  @override
  void clearLoadedData() {
    // TODO: implement clearLoadedData
  }

  @override
  void onAccountSwitch() {
    // TODO: implement onAccountSwitch
  }
}
