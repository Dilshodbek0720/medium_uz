import 'package:flutter/material.dart';
import 'package:medium_uz/presentation/auth/pages/login_page.dart';
import 'package:medium_uz/presentation/auth/pages/signup_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoginPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoginPage
          ? LoginPage(
        onChanged: () {
          setState(() {
            isLoginPage = false;
          });
        },
      )
          : SignUpScreen(
        onChanged: () {
          setState(() {
            isLoginPage = true;
          });
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}