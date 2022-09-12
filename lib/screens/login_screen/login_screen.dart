import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/routs_constants.dart';
import '../../shared_widgets/sign_up.dart';
import '../../shared_widgets/text_field.dart';
import '../../utils/auth_provider.dart';
import '../../utils/custom_state.dart';
import '../../utils/responsive.dart';
import 'login_bloc.dart';

final bloc = LoginBloc();

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends CustomState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidthSize = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 40,
                child: Container(
                  color: const Color(0xff3AB397),
                  child: SignInView(
                    screenWidthSize: screenWidthSize,
                    bloc: bloc,
                  ),
                ),
              ),
              ResponsiveWidget.isLargeScreen(context)
                  ? Expanded(
                      flex: 60,
                      child: SignUpView(screenWidthSize: screenWidthSize, bloc: bloc),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onPause() {
    bloc.pauseSubscription();
  }

  @override
  void onResume() {
    bloc.resumeSubscription();
  }

  @override
  void onStart() {
    bloc.startSubscription();
  }

  @override
  void onStop() {
    bloc.stopSubscription();
  }
}

class SignInView extends ConsumerWidget {
  const SignInView({
    Key? key,
    required this.screenWidthSize,
    required this.bloc,
  }) : super(key: key);

  final double screenWidthSize;
  final LoginBloc? bloc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginBloc = ref.watch(bloc!.loginProvider);
    final _auth = ref.watch(authenticationProvider);
    return Consumer(
      builder: (context, watch, child) {
        return child = Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            'WELCOME BACK !',
                            style: TextStyle(color: Color(0xffffffff), fontSize: 30),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(
                            'To Keep Connected with us',
                            style: TextStyle(color: Color(0xffffffff), fontSize: 15),
                          ),
                        ),
                        const Text(
                          'Please Login With Your Personal Details',
                          style: TextStyle(color: Color(0xffffffff), fontSize: 15),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: screenWidthSize / 9.2, right: screenWidthSize / 9.2, top: 16),
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: loginBloc.signInEmailFieldController,
                                hintText: 'Email',
                              ),
                              loginBloc.errorEmailMessage == 'incorrect' ? const SizedBox(height: 0) : const SizedBox(height: 5),
                              loginBloc.errorEmailMessage.isNotEmpty
                                  ? Container(
                                      margin: const EdgeInsets.only(left: 16, right: 16),
                                      child: Text(
                                        loginBloc.errorEmailMessage == 'incorrect' ? '' : loginBloc.errorEmailMessage,
                                        style: const TextStyle(color: Color(0xffE74C4C)),
                                      ),
                                    )
                                  : Container(),
                              loginBloc.errorEmailMessage == 'incorrect' ? const SizedBox(height: 0) : const SizedBox(height: 11),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: screenWidthSize / 9.2, right: screenWidthSize / 9.2),
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: loginBloc.signInPasswordFieldController,
                                hintText: 'Password',
                                keyboardType: TextInputType.text,
                                obscureText: loginBloc.obscurePasswordText,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    loginBloc.showHidePassword();
                                  },
                                  icon: const Icon(Icons.remove_red_eye),
                                ),
                              ),
                              loginBloc.errorPasswordMessage == 'incorrect' ? const SizedBox(height: 0) : const SizedBox(height: 5),
                              loginBloc.errorPasswordMessage.isNotEmpty
                                  ? Container(
                                      margin: const EdgeInsets.only(left: 16, right: 16),
                                      child: Text(
                                        loginBloc.errorPasswordMessage == 'incorrect' ? '' : loginBloc.errorPasswordMessage,
                                        style: const TextStyle(color: Color(0xffE74C4C)),
                                      ),
                                    )
                                  : Container(),
                              loginBloc.errorPasswordMessage == 'incorrect' ? const SizedBox(height: 0) : const SizedBox(height: 11),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 75,
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: const StadiumBorder(), side: const BorderSide(width: 2, color: Colors.white), fixedSize: const Size(200, 50)),
                          onPressed: () async {
                            await _auth
                                .signInWithEmailAndPassword(
                                    loginBloc.signInEmailFieldController.text, loginBloc.signInPasswordFieldController.text, context)
                                .whenComplete(
                                  () => _auth.authStateChange.listen((event) async {
                                    if (event == null) {
                                      return;
                                    }
                                  }),
                                );
                          },
                          child: const Text(
                            'SIGN IN',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        !ResponsiveWidget.isLargeScreen(context)
                            ? Padding(
                                padding: const EdgeInsets.only(top: 16, bottom: 16),
                                child: InkWell(
                                  child: const Text(
                                    'Click here to sign up',
                                    style: TextStyle(color: Color(0xffffffff), fontSize: 15),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(RoutesConstants.signUpScreen);
                                  },
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: ResponsiveWidget.isLargeScreen(context)
                    ? 250
                    : ResponsiveWidget.isMediumScreen(context)
                        ? 150
                        : 90,
                width: ResponsiveWidget.isLargeScreen(context)
                    ? 250
                    : ResponsiveWidget.isMediumScreen(context)
                        ? 150
                        : 90,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(250),
                  ),
                  color: Color(0xff4CBF97),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
