import 'package:aumet_assessment/screens/login_screen/login_bloc.dart';
import 'package:flutter/material.dart';

import '../../shared_widgets/sign_up.dart';
import '../../utils/responsive.dart';
import '../login_screen/login_screen.dart';

class SignUPScreen extends StatelessWidget {
  const SignUPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidthSize = MediaQuery.of(context).size.width;
    LoginBloc bloc = LoginBloc();
    return Scaffold(
      body: !ResponsiveWidget.isLargeScreen(context) ? SignUpView(screenWidthSize: screenWidthSize, bloc: bloc) : const LoginScreen(),
    );
  }
}
