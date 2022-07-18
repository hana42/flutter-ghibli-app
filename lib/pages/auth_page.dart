import 'package:flutter/material.dart';
import 'package:ghibli/pages/login.dart';
import 'package:ghibli/pages/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool login = true;

  @override
  Widget build(BuildContext context) {
    return login
        ? LoginWidget(onClickedSignUp: toggle)
        : SignUpWidget(onClickedSignIn: toggle);
  }

  void toggle() => setState(() => login = !login);
}
