import 'package:aumet_assessment/screens/login_screen/login_screen.dart';
import 'package:aumet_assessment/screens/signup_screen/sign_up_screen.dart';
import 'package:flutter/material.dart';

import 'constants/routs_constants.dart';
import 'screens/home_screen/home_screen.dart';

final Map<String, Widget> routes = {
  RoutesConstants.initialRoute: const LoginScreen(),
  RoutesConstants.homeScreen: const HomeScreen(),
  RoutesConstants.signUpScreen: const SignUPScreen(),
};
