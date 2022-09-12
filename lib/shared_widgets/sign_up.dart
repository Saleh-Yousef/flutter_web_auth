import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/routs_constants.dart';
import '../screens/login_screen/login_bloc.dart';
import '../utils/auth_provider.dart';
import '../utils/responsive.dart';
import 'text_field.dart';

class SignUpView extends ConsumerWidget {
  const SignUpView({
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

    return SingleChildScrollView(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 20, top: 20),
            child: Text(
              'Create Account !',
              style: TextStyle(color: Color(0xff3AB397), fontSize: 30),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidthSize / 6, right: screenWidthSize / 6, bottom: 16),
            child: CustomTextField(
              controller: loginBloc.signUpUserNameFieldController,
              hintText: 'User Name',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidthSize / 6, right: screenWidthSize / 6, bottom: 16),
            child: CustomTextField(
              controller: loginBloc.signUpPhoneFieldController,
              hintText: 'Phone',
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidthSize / 6, right: screenWidthSize / 6, bottom: 16),
            child: CustomTextField(
              controller: loginBloc.signUpEmailFieldController,
              hintText: 'Email',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidthSize / 6, right: screenWidthSize / 6),
            child: CustomTextField(
              controller: loginBloc.signUpPasswordFieldController,
              hintText: 'Password',
            ),
          ),
          const SizedBox(
            height: 75,
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFF3AB397),
                shape: const StadiumBorder(),
                side: const BorderSide(width: 2, color: Color(0xFF3AB397)),
                fixedSize: const Size(200, 50)),
            onPressed: () async {
              await _auth
                  .signUpWithEmailAndPassword(loginBloc.signUpEmailFieldController.text, loginBloc.signUpPasswordFieldController.text,
                      loginBloc.signUpUserNameFieldController.text, loginBloc.signUpPhoneFieldController.text, context)
                  .whenComplete(() => _auth.authStateChange.listen((event) async {
                        if (event == null) {
                          print('-------- account created');
                        }
                      }));
            },
            child: const Text(
              'SIGN UP',
              style: TextStyle(color: Color(0xFFFFFFFF)),
            ),
          ),
          !ResponsiveWidget.isLargeScreen(context)
              ? Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: InkWell(
                    child: const Text(
                      'Click here to sign in',
                      style: TextStyle(color: Color(0xFF3AB397), fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(RoutesConstants.initialRoute);
                    },
                  ),
                )
              : Container()
        ]),
      ),
    );
  }
}
