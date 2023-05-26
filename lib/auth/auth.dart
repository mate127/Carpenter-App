import 'package:carpenter_app/auth/login.dart';
import 'package:carpenter_app/auth/register.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  void toggle() => setState(() {
        isLogin = !isLogin;
      });
  @override
  Widget build(BuildContext context) {
    return isLogin
        ? LoginScreen(showRegisterScreen: toggle)
        : RegisterScreen(showLoginScreen: toggle);
  }
}
